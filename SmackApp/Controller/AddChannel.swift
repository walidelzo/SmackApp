//
//  AddChannel.swift
//  SmackApp
//
//  Created by Admin on 3/16/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class AddChannel: UIViewController,UITextFieldDelegate {
    //Outlets
    
    @IBOutlet weak var bgview: UIView!
    
    @IBOutlet weak var namTXT: TextFieldPlaceHolder!
    @IBOutlet weak var descriptionTXT: TextFieldPlaceHolder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namTXT.delegate = self
        descriptionTXT.delegate = self
        // Do any additional setup after loading the view.
        let closeTapGes = UITapGestureRecognizer(target: self, action: #selector(AddChannel.tapFunc(_:)))
        bgview.addGestureRecognizer(closeTapGes)
       
        
        //to dismiss keyboard
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(AddChannel.handleTap(_:)))
        view.addGestureRecognizer(tapGes)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         namTXT.resignFirstResponder()
        descriptionTXT.resignFirstResponder()
        return true
    }
    
   
    
  
    
    @objc func handleTap(_ recognizer:UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    //gesture method
    
    @objc func tapFunc (_ recognizer:UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    ///IbActions
    
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelpressd(_ sender: Any)
    {
        guard let nameOfChannel = namTXT.text , namTXT.text != ""  else { return  }
        guard let descriptionOfchannel  = descriptionTXT.text , descriptionTXT.text != "" else { return }
        SocketService.instance.addChannel(channelName: nameOfChannel, channeDescription: descriptionOfchannel) { (Success) in
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
}
