//
//  ChatVC.swift
//  SmackApp
//
//  Created by Admin on 3/10/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class ChatVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:- IBoutlets
    @IBOutlet var menuBtn: UIButton!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var messageTXT: UITextField!
    @IBOutlet weak var tableview:UITableView!
    //MARK:- IBACTIONS
    @IBAction func sendBtnPressed(_ sender: Any) {
    
        if AuthService.instance.islogIn {
           guard let message = messageTXT.text , messageTXT.text != "" else {return}
            guard let channelId = MassegeDataService.instance.selectedChannel?.id else {return}
            
            SocketService.instance.addMesaageWithBody(messageBody: message, channelId: channelId, userId: UserDataService.instance.id) { (success) in
                if success{
                    self.messageTXT.text = ""
                    self.messageTXT.resignFirstResponder()
                }
            }
            
            
        }
        
    }
    
    //MARK:- view method
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.estimatedRowHeight = 80
        //tableview.rowHeight = automaticDimension
        
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
        }else{
            channelLabel.text = "Please Login First"
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
