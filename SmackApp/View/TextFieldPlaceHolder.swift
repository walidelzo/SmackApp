//
//  TextFieldPlaceHolder.swift
//  SmackApp
//
//  Created by Admin on 3/14/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class TextFieldPlaceHolder: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    
    func setUpView(){
        if let placeHolder = placeholder {
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor : #colorLiteral(red: 0.3266413212, green: 0.4215201139, blue: 0.7752227187, alpha: 0.5)])
        }
        
        
    }
}
