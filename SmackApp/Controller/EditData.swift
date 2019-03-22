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
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
    @IBAction func SaveBtnPressed(_ sender: Any) {
        indicator.startAnimating()
        indicator.isHidden = false
        
        guard let newUserName = usernameTXT.text  else { return  }
        AuthService.instance.updateUser(newName: newUserName) { (Success) in
            if (Success){
                self.dismiss(animated: true, completion: nil)
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
        let tap =   UITapGestureRecognizer(target: self, action: #selector(handelTap))
        bgView.addGestureRecognizer(tap)
        let dismisKeyBoard  = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(dismisKeyBoard)
    }
   @objc func handelTap (){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func dismissKeyBoard()
    {
    self.view.endEditing(true)
    }
}
