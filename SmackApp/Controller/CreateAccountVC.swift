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
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    /// var
    var avatarName:String = "profileDefault"
    var avatarColor:String = "[0.5,0.5,0.5,1]"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let tapGes = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tapGes)
    }
    
   @objc func handleTap(){
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            self.avatarName = UserDataService.instance.avatarName
            avatarImageView.image = UIImage(named: self.avatarName)
            self.avatarColor = UserDataService.instance.avatarName
            if avatarColor.contains("light"){
                avatarImageView.backgroundColor = UIColor.darkGray
            }
        }
        
    }
    
    // @ibAction
    
    @IBAction func signUpPressed(_ sender: Any) {
        indicator.startAnimating()
        indicator.isHidden = false
        guard let name = userNameTxt.text , userNameTxt.text != ""   else { return }
        guard let email = emailTxt.text , emailTxt.text != ""   else { return }
        guard let pass = passWordTxt.text , passWordTxt.text != "" else { return  }
        
        AuthService.instance.registerUser(withEmailAddress: email, AndPassWord: pass) { (Success ) in
            if (Success){
                AuthService.instance.logingUser(email: email, password: pass, completion: { (Success) in
                    if (Success){
                        AuthService.instance.addUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            self.performSegue(withIdentifier: TO_WIND_TO_CHANNEL_SEGUE, sender: nil)
                            NotificationCenter.default.post(name: NOTIFY_USER_DATA_CHANGED, object: nil)
                        })
                        
                    }
                })

            }
        }
        
        
    }
    
    @IBAction func geratecolorPressed(_ sender: Any) {
        
        let r = CGFloat (arc4random_uniform(255)) / 255
        let b = CGFloat (arc4random_uniform(255)) / 255
        let g = CGFloat (arc4random_uniform(255)) / 255
        
        let randomColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r) , \(g) , \(b) , 1]"
        UIView.animate(withDuration: 0.2){
       self.avatarImageView.backgroundColor = randomColor
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: To_AVATAR_PICKER, sender: nil)
    }
    @IBAction func closeActionPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_WIND_TO_CHANNEL_SEGUE, sender: nil)
        
    }
}
