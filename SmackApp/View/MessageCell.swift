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
        MessageLbl.text = message.message
        
        guard  var isoDate = message.timeStamp else {return}
        let index = (isoDate.count - 5)
        isoDate = String(isoDate.prefix(index))
        isoDate = isoDate.appending("Z")

        let isoFormmatter = ISO8601DateFormatter()
        let chatDate = isoFormmatter.date(from: isoDate)
        //timeStampLbl.text = isoDate
        
        let newFormmater = DateFormatter()
       newFormmater.dateFormat = "MMM d , hh:mm a"
      if let fomattedTime = chatDate {
     timeStampLbl.text = newFormmater.string(from: fomattedTime)
     }
        
    }
    
    
    
}
