//
//  ChatVC.swift
//  SmackApp
//
//  Created by Admin on 3/10/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    //MARK:- IBoutlets
    @IBOutlet var menuBtn: UIButton!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var messageTXT: UITextField!
    
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

        }
    }
    
//    func sendMessage(){
//        let userId = UserDataService.instance.id
//        let channelId = "5c8d22fc864c3c0574b70258"
//        let username = UserDataService.instance.name
//        let avatarname = UserDataService.instance.avatarName
//        let avatarColor = UserDataService.instance.avatarColor
//
//        SocketService.instance.socketClient.emit("newMessage","Hello objective-c", userId,channelId,username,avatarname,avatarColor)
//        print("the message was sent ......> .....")
//    }
    
    
}
