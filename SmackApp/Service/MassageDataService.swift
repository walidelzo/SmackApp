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
    //this is array of channel struct
    var channels = [Channel]()
    
    //this function to retrive all channel from api by Alamofire
    
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
                        //print(channel.name!)
                    }
                }
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
}
