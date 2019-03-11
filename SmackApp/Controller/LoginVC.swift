//
//  LoginVC.swift
//  SmackApp
//
//  Created by Admin on 3/11/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func CloseBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATEACOUNT, sender: nil)
        
    }
}
