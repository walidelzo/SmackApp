//
//  RoundedButton.swift
//  SmackApp
//
//  Created by Admin on 3/12/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var radiusValue : CGFloat = 5.0
        {
        
        didSet{  self.setNeedsLayout()    }
    }
    
    override func awakeFromNib() {
        self.setUp()
    }
    
    
    func setUp(){
        self.layer.cornerRadius = radiusValue
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setUp()
    }
    
    
}
