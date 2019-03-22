//
//  RoundedTextView.swift
//  SmackApp
//
//  Created by Admin on 3/21/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class RoundedTextView: UITextView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8.0
        layer.borderWidth = 1
        layer.borderColor = SMACK_COLOR.cgColor
        textColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
       backgroundColor = UIColor.clear
    }

}
