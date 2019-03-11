//
//  CreateAccountVC.swift
//  SmackApp
//
//  Created by Admin on 3/11/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func closeActionPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_WIND_TO_CHANNEL_SEGUE, sender: nil)
        
    }
}
