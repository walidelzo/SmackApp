//
//  MessageCell.swift
//  SmackApp
//
//  Created by Admin on 3/19/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    //MARK:- Oulets
    
    @IBOutlet weak var imageMessage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var MessageLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell (message:Message){
        imageMessage.backgroundColor =  UserDataService.instance.returnColor(avatarColorString: message.userAvatarColor)
        imageMessage.image = UIImage(named: message.userAvatar)
        userNameLbl.text = message.userName
        //timeStampLbl.text = message.timeStamp
        MessageLbl.text = message.message
    }

   

}
