//
//  avatarCell.swift
//  SmackApp
//
//  Created by Admin on 3/13/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class avatarCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView(){
        layer.cornerRadius = 10.0
        layer.backgroundColor = UIColor.lightGray.cgColor
        clipsToBounds = true
    }
    
    
}
