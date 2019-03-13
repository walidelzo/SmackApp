//
//  avatarCell.swift
//  SmackApp
//
//  Created by Admin on 3/13/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

enum AvatarType{
    case dark
    case light
}


class avatarCell: UICollectionViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func ConfigCell (index:Int ,type:AvatarType){
        if type == .dark {
            avatarImage.backgroundColor = UIColor.lightGray
            avatarImage.image = UIImage(named: "dark\(index)")
        }else{
            avatarImage.backgroundColor = UIColor.clear
            avatarImage.image = UIImage(named: "light\(index)")
        }
    }
    
    func setUpView(){
        layer.cornerRadius = 10.0
        layer.backgroundColor = UIColor.lightGray.cgColor
        clipsToBounds = true
    }
    
    
}
