//
//  Profile.swift
//  SmackApp
//
//  Created by Admin on 3/14/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class Profile: UIViewController {
    
    //MARK:- IBOutlets
    
    
    @IBOutlet weak var BgView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userEmailLBL: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    @IBAction func chanegNamePressed(_ sender: Any) {
        if AuthService.instance.islogIn {
            let editVC = EditData()
            editVC.modalPresentationStyle = .custom
            present(editVC, animated: true, completion: nil)
        }
    }
    //MARK:-  IBActions
    
    @IBAction func closeProfileBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        UserDataService.instance.logOut()
        NotificationCenter.default.post(name: NOTIFY_USER_DATA_CHANGED, object: nil)
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func picAvatar(_ sender :Any){
        
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(Profile.setUpView), name:NOTIFY_USER_DATA_EDITED, object: nil)
        setUpView()
    }
    
    //MARK:- setView Method
   @objc func setUpView(){
        userName.text = UserDataService.instance.name
        userEmailLBL.text = UserDataService.instance.email
        profileImage.image = UIImage(named: UserDataService.instance.avatarName)
        profileImage.backgroundColor = UserDataService.instance.returnColor(avatarColorString: UserDataService.instance.avatarColor)
        
        let closeByTap = UITapGestureRecognizer(target: self, action: #selector(gestusDismissScreen))
        BgView.addGestureRecognizer(closeByTap)
        
        
    }
    
 @objc   func gestusDismissScreen (){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
