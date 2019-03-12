//
//  CreateAccountVC.swift
//  SmackApp
//
//  Created by Admin on 3/11/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    //OutLets
    
    @IBOutlet weak var userNameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passWordTxt: UITextField!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    // @ibAction
    
    @IBAction func signUpPressed(_ sender: Any) {
        guard let email = emailTxt.text , emailTxt.text != ""   else { return }
        guard let pass = passWordTxt.text , passWordTxt.text != "" else { return  }
        
        AuthService.instance.registerUser(withEmailAddress: email, AndPassWord: pass) { (Success ) in
            if (Success){
                print("the user is registerd")
            }
        }
        
        
    }
    
    @IBAction func geratecolorPressed(_ sender: Any) {
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    @IBAction func closeActionPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_WIND_TO_CHANNEL_SEGUE, sender: nil)
        
    }
}
