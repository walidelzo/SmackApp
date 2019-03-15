//
//  LoginVC.swift
//  SmackApp
//
//  Created by Admin on 3/11/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var emailTXT: UITextField!
    
    @IBOutlet weak var passWordTXT: UITextField!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        indicator.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func CloseBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATEACOUNT, sender: nil)
        
    }
    
    @IBAction func logingBtnPressed(_ sender: Any) {
        indicator.isHidden = false
        indicator.startAnimating()
        
        guard let email = emailTXT.text , emailTXT.text != "" else { return  }
        guard let password = passWordTXT.text  , passWordTXT.text != "" else { return }
        
        AuthService.instance.logingUser(email: email, password: password) { (success) in
            if (success){

                AuthService.instance.findUserByEmail(completion: { (Success) in
                    if (Success){

                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        NotificationCenter.default.post(name: NOTIFY_USER_DATA_CHANGED, object: nil)
                        self.dismiss(animated: true, completion: nil)

                    }
                })
                
                
            }
        }
        
        
        
    }
    
}
