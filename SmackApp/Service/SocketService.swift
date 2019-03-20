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
    
    //Get Channel in real time mode by SocketIO
    
    func getChannel (completion:@escaping completionHandler){
        socketClient.on("channelCreated") { (arrayOfData, ack) in
            
            guard let channelNamee = arrayOfData[0] as? String else {return }
            guard let channelDescription = arrayOfData[1] as? String else {return}
            guard let channelId = arrayOfData[2] as?String else {return}
            
            let channel = Channel(id: channelId, name: channelNamee, description: channelDescription)
            MassegeDataService.instance.channels.append(channel)
           completion(true)
        }
        
    }
    
    //MARK:- Add message from user to channel which he selected
    
    func addMesaageWithBody(messageBody:String,channelId:String,userId:String ,completion:@escaping completionHandler){
       let user = UserDataService.instance
        socketClient.emit("newMessage", messageBody,userId ,channelId,user.name,user.avatarName,user.avatarColor)
        completion(true)
    }
    
    
    //MARK:- getMessage function get all message by socket (real time)
    func getMessages(complition:@escaping  (_ messages:Message)->Void){
        
        socketClient.on("messageCreated") { (dataArray, ack) in
            
            
            guard let messageBody = dataArray[0] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let avatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as?String else {return}
            
            let newMessage = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: avatarColor, id: id, timeStamp: timeStamp)
            MassegeDataService.instance.messages.append(newMessage)
            
            complition(newMessage)
        }
    }
    
    
    func getTypingUsers(_ ComplitionHandler: @escaping (_ typingUsers : [String : String]  ) -> Void){
        socketClient.on("userTypingUpdate") { (dataArray, ack) in
            guard  let typingUsers = dataArray[0] as? [String : String] else {return}
            ComplitionHandler(typingUsers)
        }
    }
    
    
}
