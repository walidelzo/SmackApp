//
//  Channel VC.swift
//  SmackApp
//
//  Created by Admin on 3/10/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class Channel_VC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60
    }
    
    
    
}
