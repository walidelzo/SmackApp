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
    
    func returnColor (avatarColorString:String)->UIColor{
        
        let scanner = Scanner (string: avatarColorString)
        let skipedChar = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipedChar
        
        var r , g , b , a :NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaulColor = UIColor.lightGray
        
        guard let unWrapedR = r else {return defaulColor}
        guard let unWappedB = b else {return defaulColor}
        guard let unWrapedG = g else {return defaulColor}
        guard let unWrappedA = a else {return defaulColor}
        
        let floatR = CGFloat(unWrapedR.doubleValue)
        let floatB = CGFloat(unWappedB.doubleValue)
        let floatG = CGFloat(unWrapedG.doubleValue)
        let floatA = CGFloat(unWrappedA.doubleValue)
        
        
        let NewColor = UIColor(red: floatR, green: floatG, blue: floatB, alpha: floatA)
       
        return NewColor
    }
    
    func logOut(){
        id = ""
        name = ""
        email = ""
        avatarName = ""
        avatarColor = ""
        AuthService.instance.islogIn = false
        AuthService.instance.AuthToken = ""
        AuthService.instance.userEmail = ""
        MassegeDataService.instance.clearChannel()
    }
    
}
