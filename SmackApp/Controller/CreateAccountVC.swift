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
    
    @IBOutlet weak var signUpBtn: RoundedButton!
    
    /// var
    var avatarName:String = "profileDefault"
    var avatarColor:String = "[0.5,0.5,0.5,1]"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       // signUpBtn.isEnabled = true
    }
    
    
    
    // @ibAction
    
    @IBAction func signUpPressed(_ sender: Any) {
        signUpBtn.isEnabled = false
        guard let name = userNameTxt.text , userNameTxt.text != ""   else { return }
        guard let email = emailTxt.text , emailTxt.text != ""   else { return }
        guard let pass = passWordTxt.text , passWordTxt.text != "" else { return  }
        
        AuthService.instance.registerUser(withEmailAddress: email, AndPassWord: pass) { (Success ) in
            if (Success){
                AuthService.instance.logingUser(email: email, password: pass, completion: { (Success) in
                    if (Success){
                        AuthService.instance.addUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            self.performSegue(withIdentifier: TO_WIND_TO_CHANNEL_SEGUE, sender: nil)
                            print(AuthService.instance.userEmail + " " + UserDataService.instance.avatarName)
                            
                        })
                        
                    }
                })

            }
        }
        
        
    }
    
    @IBAction func geratecolorPressed(_ sender: Any) {
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: To_AVATAR_PICKER, sender: nil)
    }
    @IBAction func closeActionPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_WIND_TO_CHANNEL_SEGUE, sender: nil)
        
    }
}
