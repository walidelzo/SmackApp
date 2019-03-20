//
//  ChannelCell.swift
//  SmackApp
//
//  Created by Admin on 3/16/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    //OutLets
    
    @IBOutlet weak var channelTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected{
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func conFigureCell(channel:Channel){
        let title = channel.name ?? ""
        channelTitle.text = "#\(title)"
        channelTitle.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        for id in MassegeDataService.instance.unReadChannel
        {
            if id == channel.id && MassegeDataService.instance.selectedChannel?.id != id
            {
                channelTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
                
            }
        }
        
    }
    
}
