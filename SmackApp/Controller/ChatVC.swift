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
        
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: NOTIFY_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.islogIn
        {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIFY_USER_DATA_CHANGED, object: nil)
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
                //do with massgess
            }
        }
    }
    
    @objc func channelSelected(_ notifi: Notification ){
        updateWithChannel()
    }
    
    func updateWithChannel(){
        let channelName = MassegeDataService.instance.selectedChannel?.name ?? ""
        channelLabel.text = "#\(channelName)"
    }
    
}
