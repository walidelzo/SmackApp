//
//  RoundedImage.swift
//  SmackApp
//
//  Created by Admin on 3/14/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {

    override func awakeFromNib() {
        setUp()
    }
    
    
    func setUp(){
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
}
