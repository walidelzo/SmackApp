//
//  Gradientview.swift
//  SmackApp
//
//  Created by Admin on 3/10/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

@IBDesignable
class Gradientview: UIView {
    @IBInspectable var topColor:UIColor =  #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1){
        
        didSet{
            self.setNeedsLayout()
        }


    }
    
    @IBInspectable var buttomColor:UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1)
        {
            
        didSet{
            self.setNeedsLayout()
        }
            
            
    }
    
    override func layoutSubviews() {
        
        let gridientLayer = CAGradientLayer()
        gridientLayer.colors = [topColor.cgColor , buttomColor.cgColor]
        gridientLayer.startPoint = CGPoint(x: 0, y: 0)
        gridientLayer.endPoint = CGPoint(x: 1, y: 1)
        gridientLayer.frame = self.bounds
        self.layer.insertSublayer(gridientLayer, at: 0)
        
    }
    
    
    
    

}
