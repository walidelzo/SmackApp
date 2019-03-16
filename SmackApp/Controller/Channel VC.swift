//
//  Channel VC.swift
//  SmackApp
//
//  Created by Admin on 3/10/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class Channel_VC: UIViewController {
    @IBAction func prepareUnWindSegue(segue:UIStoryboardSegue){}
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var menuProfileImage: RoundedImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(Channel_VC.userDataDidChanged(_:)), name: NOTIFY_USER_DATA_CHANGED, object: nil)
        }
    
    override func viewDidAppear(_ animated: Bool) {
        setUserInfo()
    }
    
    
    @objc func userDataDidChanged (_ notifi:Notification){
        
        setUserInfo()
    }
    
    func setUserInfo(){
        if AuthService.instance.islogIn {
            menuProfileImage.image = UIImage(named:UserDataService.instance.avatarName)
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            menuProfileImage.backgroundColor = UserDataService.instance.returnColor(avatarColorString: UserDataService.instance.avatarColor)
       
            
          

        
        }else{
            menuProfileImage.image = UIImage (named: "menuProfileIcon")
            loginBtn.setTitle("Login", for: .normal)
        }
        
    }
    
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.islogIn {
            let profileVC = Profile()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
    }
    
}
