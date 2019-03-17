//
//  MassageDataService.swift
//  SmackApp
//
//  Created by Admin on 3/15/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MassegeDataService {
    
    //make instance as a single tone
    static let instance = MassegeDataService()
    //this is array of channels and messages struct
    var channels = [Channel]()
    var messages = [Message]()
    
    var selectedChannel :Channel?
    //this function to retrive all channel from api by Alamofire
    
    
    //Mark:-  find all Channel in dataBase
    
    func findAllChannels(completion:@escaping completionHandler){
        
        Alamofire.request(URL_CHANNEL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BREARER_HEADER).responseJSON { (response) in
            
            if (response.result.error == nil){
                    ///
                guard let data = response.data else {return}
                if  let json = try? JSON(data: data).array
                {
                    for item in json!{
                        let id  = item["_id"].stringValue
                        let name = item["name"].stringValue
                        let description = item["description"].stringValue
                        
                        let channel = Channel.init(id: id, name: name, description: description)
                        self.channels.append(channel)
                        NotificationCenter.default.post(name: NOTIFY_CHANNEL_LOADED, object: nil)
                    }
                }
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    //MARK:- find All message by Channel id
    
    
    func findAllMessagesForChannel (channelId:String , completion :@escaping completionHandler){
        
        Alamofire.request("\(URL_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BREARER_HEADER).responseJSON { (response) in
            if (response.result.error == nil){
                self.clearMessage()
                guard let data = response.data else {return}
                if let json = try? JSON(data: data).array
                {
                    for item in json!{
                        
                        //Make properties to create massage
                        let id  = item["_id"].stringValue
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let username = item["userName"].stringValue
                        let avatarName = item["userAvatar"].stringValue
                        let avatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        //create massage from message struct
                        let message = Message.init(message: messageBody, userName: username, channelId: channelId, userAvatar: avatarName, userAvatarColor: avatarColor, id: id, timeStamp: timeStamp)
                        
                       self.messages.append(message)
                        print("-----> the count of mesaage \(self.messages.count) ")
                        print(self.messages)

                    }
                }
                
                
               completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
    func clearMessage(){
        messages.removeAll()
    }
    func clearChannel(){
        channels.removeAll()
    }
}
