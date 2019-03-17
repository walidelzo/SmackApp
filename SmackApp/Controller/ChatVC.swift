//
//  ChatVC.swift
//  SmackApp
//
//  Created by Admin on 3/10/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    @IBOutlet var menuBtn: UIButton!
    @IBOutlet weak var channelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add revealaction to menu button
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        // add gestureRecogonizer to my view
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        
        //add notifcation observer to channel login
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChanged(_:)), name: NOTIFY_USER_DATA_CHANGED, object: nil)
        //add notification to observe which channel selected
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIFY_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.islogIn
            {
            AuthService.instance.findUserByEmail
                { (success) in
                NotificationCenter.default.post(name: NOTIFY_USER_DATA_CHANGED, object: nil)
                   // self.sendMessage()
                }
            }
    }
    
    
    @objc func userDataDidChanged (_ notifi:Notification){
        if AuthService.instance.islogIn{
            onLoginGetMasseges()
        }else{
            channelLabel.text = "Please Login First"
        }
        
    }
    
    func onLoginGetMasseges(){

        MassegeDataService.instance.findAllChannels { (suss) in

            if (suss){

                if  MassegeDataService.instance.channels.count > 0
                {
                    MassegeDataService.instance.selectedChannel = MassegeDataService.instance.channels[0]
                    self.updateWithChannel()
                }
                else
                {
                    self.channelLabel.text = "no Channel  here "

                }
                
            }
        }
        
    }
    
    
    @objc func channelSelected(_ notifi: Notification ){
        updateWithChannel()
    }
    
    func updateWithChannel(){
        let channelName = MassegeDataService.instance.selectedChannel?.name ?? "Smack"
        channelLabel.text = "#\(channelName)"
        getMessages()
    }
    
    func getMessages(){
        guard let  channelID = MassegeDataService.instance.selectedChannel?.id else { return }
        MassegeDataService.instance.findAllMessagesForChannel(channelId: channelID) { (succ) in
        }
    }
    
    func sendMessage(){
        let userId = UserDataService.instance.id
        let channelId = "5c8d22fc864c3c0574b70258"
        let username = UserDataService.instance.name
        let avatarname = UserDataService.instance.avatarName
        let avatarColor = UserDataService.instance.avatarColor
        
        SocketService.instance.socketClient.emit("newMessage","Hello objective-c", userId,channelId,username,avatarname,avatarColor)
        print("the message was sent ......> .....")
    }
    
    
}
