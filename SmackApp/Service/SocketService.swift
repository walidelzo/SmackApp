//
//  SocketService.swift
//  SmackApp
//
//  Created by Admin on 3/16/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit
import SocketIO

class SocketService :NSObject {

   static let instance = SocketService()
   
    let socketManager : SocketManager
    let socketClient : SocketIOClient
    
    override init() {
        socketManager = SocketManager(socketURL: URL(string: BASE_URL)!)
        socketClient = socketManager.defaultSocket
        super.init()
    }
    
    func establishConnection(){
        socketClient.connect()
    }
    
    func closeConntection(){
        socketClient.disconnect()
    }
    
    // with Socket io We make a channel with emit Function
    func addChannel (channelName :String , channeDescription:String , completion:@escaping completionHandler){
        socketClient.emit("newChannel", channelName, channeDescription)
        completion(true)
        
    }
    
    func getChannel (completion:@escaping completionHandler){
        socketClient.on("channelCreated") { (arrayOfData, ack) in
            
            guard let channelNamee = arrayOfData[0] as? String else {return }
            guard let channelDescription = arrayOfData[1] as? String else {return}
            guard let channelId = arrayOfData[2] as?String else {return}
            
            let channel = Channel.init(id: channelId, name: channelNamee, description: channelDescription)
            MassegeDataService.instance.channels.append(channel)
           completion(true)
        }
        
    }
    
    
}
