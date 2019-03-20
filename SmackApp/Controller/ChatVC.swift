//
//  ChatVC.swift
//  SmackApp
//
//  Created by Admin on 3/10/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class ChatVC: UIViewController ,UITableViewDelegate,UITableViewDataSource ,UITextFieldDelegate {
    
    //MARK:- IBoutlets
    @IBOutlet var menuBtn: UIButton!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var messageTXT: UITextField!
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var typingLbl: UILabel!
    
    /// variables
    
    var isTyping = false
    
    //MARK:- IBACTIONS
    @IBAction func sendBtnPressed(_ sender: Any) {
    sendMessage()
        
    }
    
    @IBAction func messageTXTEditing(_ sender: Any) {
        guard let channelId = MassegeDataService.instance.selectedChannel?.id else {return}
        if messageTXT.text == "" {
            isTyping = false
            sendBtn.isHidden = true
            SocketService.instance.socketClient.emit("stopType" ,UserDataService.instance.name ,channelId)
            self.typingLbl.text = ""
        }else{
            if isTyping == false {
                sendBtn.isHidden = false
            }
            isTyping = true
            SocketService.instance.socketClient.emit("startType",UserDataService.instance.name , channelId)

        }
    }
    
    //MARK:- view method
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        tableview.delegate = self
        messageTXT.delegate = self
        tableview.dataSource = self
       tableview.estimatedRowHeight = 80
        tableview.rowHeight = UITableView.automaticDimension
        sendBtn.isHidden = true
        // add revealaction to menu button
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        // add gestureRecogonizer to my view
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        let tapKeyBoard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tapKeyBoard)
        
        //add notifcation observer to channel login
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChanged(_:)), name: NOTIFY_USER_DATA_CHANGED, object: nil)
        //add notification to observe which channel selected
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIFY_CHANNEL_SELECTED, object: nil)
        
        //Get Messages by SocketIO
        SocketService.instance.getMessages { (newMesages) in
            if newMesages.channelId == MassegeDataService.instance.selectedChannel?.id && AuthService.instance.islogIn{
                
                MassegeDataService.instance.messages.append(newMesages)
                self.tableview.reloadData()
                self.scrollTable()
                self.typingLbl.text = ""
            }
            
          

        }
        
        // get user are typing by SocketIO
        SocketService.instance.getTypingUsers { (usersTyping) in
            guard let channelId = MassegeDataService.instance.selectedChannel?.id else {return}
            var name = ""
            var numberOfUsers = 0
            for (userTyping ,channel ) in usersTyping{
                if userTyping != UserDataService.instance.name && channel == channelId{
                    if name == ""
                    {
                        name = userTyping
                    }else {
                        name = "\(name) , \(userTyping)"
                    }
                    numberOfUsers += 1
                }
                
                if numberOfUsers > 0 && AuthService.instance.islogIn {
                    var verbs = " is "
                    if numberOfUsers > 1 {
                        verbs = " are "
                    }
                    self.typingLbl.text = "\(name) \(verbs) typing as message"
                }else{
                    self.typingLbl.text = ""
                }
            }
            
        }
        
        if AuthService.instance.islogIn
            {
            AuthService.instance.findUserByEmail
                { (success) in
                NotificationCenter.default.post(name: NOTIFY_USER_DATA_CHANGED, object: nil)
                }
            }
        

    }
    
    // this method to tapGestureRecoginzer
  @objc  func dismissKeyBoard (){
        view.endEditing(true)
    }
    
    // MARK:- Notification Observed Methods
    
    @objc func userDataDidChanged (_ notifi:Notification){
        if AuthService.instance.islogIn{
            onLoginGetMasseges()
           // revealViewController()?.revealToggle(animated: true)

        }else{
            channelLabel.text = "Please Login First"
            self.tableview.reloadData()
            revealViewController()?.revealToggle(animated: true)

        }
        
    }
    
    func onLoginGetMasseges(){
        MassegeDataService.instance.findAllChannels { (suss) in

            if suss {
                if  MassegeDataService.instance.channels.count > 0
                {
                    MassegeDataService.instance.selectedChannel = MassegeDataService.instance.channels[0]
                    self.updateWithChannel()
                }
                else
                {
                    self.channelLabel.text = "No Channel  here "
                }
                
            }
        }
        
    }
    
    
    @objc func channelSelected(_ notifi: Notification ){
        updateWithChannel()
    }
    
    func updateWithChannel(){
        let channelName = MassegeDataService.instance.selectedChannel?.name ?? ""
        channelLabel.text = "#\(channelName)"
        getMessages()
    }
    
    func getMessages(){
        guard let  channelID = MassegeDataService.instance.selectedChannel?.id else { return }
        MassegeDataService.instance.findAllMessagesForChannel(channelId: channelID) { (succ) in
            if succ {
                self.tableview.reloadData()
                self.scrollTable()

            }

        }
    }
    
    
    func scrollTable(){
        if MassegeDataService.instance.messages.count > 0 {
            let inIndex = IndexPath(row: (MassegeDataService.instance.messages.count - 1), section: 0)
            self.tableview.scrollToRow(at: inIndex, at: .bottom, animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        messageTXT.resignFirstResponder()
        return true
    }
    
    
    func sendMessage(){
        if AuthService.instance.islogIn {
            guard let message = messageTXT.text , messageTXT.text != "" else {return}
            guard let channelId = MassegeDataService.instance.selectedChannel?.id else {return}
            
            SocketService.instance.addMesaageWithBody(messageBody: message, channelId: channelId, userId: UserDataService.instance.id) { (success) in
                if success{
                    self.messageTXT.text = ""
                    self.messageTXT.resignFirstResponder()
                    SocketService.instance.socketClient.emit("stopType", UserDataService.instance.name , channelId)
                    
                    
                    
                }
            }
            
            
        }

    }
    
    
    //MARK:- TableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MassegeDataService.instance.messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell
        {
            let messageOne = MassegeDataService.instance.messages[indexPath.row]
            cell.configureCell(message: messageOne)
            return cell 
            
        }else{
            return MessageCell()
        }
    }
    
    
    
    
}
