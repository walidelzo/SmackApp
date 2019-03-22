//
//  EditData.swift
//  SmackApp
//
//  Created by Admin on 3/21/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class EditData: UIViewController {
//OutLts
    
    @IBOutlet weak var usernameTXT: UITextField!

    @IBOutlet weak var bgView: UIView!
    //IBActions
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
    @IBAction func SaveBtnPressed(_ sender: Any) {
        guard let newUserName = usernameTXT.text  else { return  }
        AuthService.instance.updateUser(newName: newUserName) { (Success) in
            if (Success){
                self.dismiss(animated: true, completion: nil)
                print("the user name is changed")
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap =   UITapGestureRecognizer(target: self, action: #selector(handelTap))
        bgView.addGestureRecognizer(tap)
    }
   @objc func handelTap (){
        self.dismiss(animated: true, completion: nil)
    }

}
