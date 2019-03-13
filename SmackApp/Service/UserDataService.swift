//
//  UserDataService.swift
//  SmackApp
//
//  Created by Admin on 3/13/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import Foundation

class UserDataService {
    //create Singletone instance of userdataservice
    static let instance = UserDataService()
    
    public private(set) var id:String = ""
    public private(set) var name:String = ""
    public private(set) var email:String = ""
    public private(set) var avatarName:String = ""
    public private(set) var avatarColor:String = ""
    
    func setUserData(id:String,name:String,email:String,avatarName:String,avatarcolor:String){
        self.id=id
        self.name=name
        self.email=email
        self.avatarName=avatarName
        self.avatarColor=avatarcolor
        
    }
    
    
    func setAvatarName(avatarName:String){
        self.avatarName = avatarName
    }
    
}
