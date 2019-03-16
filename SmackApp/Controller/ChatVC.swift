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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // add revealaction to menu button
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)

        // add gestureRecogonizer to my view
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        
        if AuthService.instance.islogIn
        {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIFY_USER_DATA_CHANGED, object: nil)
            }
       
            MassegeDataService.instance.findAllChannels { (Success) in
                //
            }

        }
    }
    

}
