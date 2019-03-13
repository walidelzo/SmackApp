//
//  AuthService.swift
//  SmackApp
//
//  Created by Admin on 3/12/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import Foundation
import  Alamofire
import SwiftyJSON
class AuthService {
    
    static let instance = AuthService()
    let defaults = UserDefaults.standard
  
    
    //MARK: - variables
    
    // make variabe check if user registred or no
    var islogIn :Bool{
        
        get{
            return defaults.bool(forKey: LOGED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: LOGED_IN_KEY)
        }
    }
    
    // var token return token Id (String value)
    var AuthToken :String {
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    ///var userEmail as String value from userDefaults
    
    var userEmail :String {
        
        get {
            return defaults.value(forKey: USER_EMAIL_KEY) as! String
        }
        
        set {
            defaults.set(newValue, forKey: USER_EMAIL_KEY)
        }
        
    }
    
    
    // MARK:- Functions
    
    //func to register email and password
    
    func registerUser(withEmailAddress Email:String , AndPassWord passWord :String , completion : @escaping completionHandler )
    {
        let lowerCaseEmail = Email.lowercased()
        
        let body : [String:Any] = [
            "email":lowerCaseEmail,
            "password":passWord
        ]
        
        Alamofire.request(REGISTER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            if (response.result.error == nil)
            {
                completion(true)
                
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
            
            
        }
        
        
        
        
        
    }
  
    
    ///Login function
    
    func logingUser(email:String , password:String , completion :@escaping completionHandler){
        
        let loweCaseEmail = email.lowercased()
        let body :[String :Any] = [
            "email":loweCaseEmail ,
            "password":password
        ]
        
        
        Alamofire.request(LOGIN_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if (response.result.error == nil)
            {

//                // use swiftyjson
                guard let data = response.data else {return}
                 let json = try? JSON(data: data)
                self.userEmail = json!["user"].stringValue
                self.AuthToken = json!["token"].stringValue
                self.islogIn = true
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    /// add user Function
    
    func addUser (name:String,email:String,avatarName:String,avatarColor:String ,completion :@escaping completionHandler ){
        
        let lowerCaseEmail = email.lowercased()
        
        let body : [String : Any] = [
            "name":name ,
            "email":lowerCaseEmail,
            "avatarName":avatarName,
            "avatarColor":avatarColor
        ]
        
        let header = [
            "Authorization" : "Bearer \(AuthService.instance.AuthToken)" ,
            "Content-Type" : "application/json; charset=utf-8"
        ]
        
        Alamofire.request(ADD_USER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if (response.result.error == nil){
                
                // here we can user SwiftyJSON
                guard let data = response.data else {return}
                let json = try? JSON(data:data)
                
                let id = json!["_id"].stringValue
                let name = json!["name"].stringValue
                let email = json!["email"].stringValue
                let avatarName = json!["avatarName"].stringValue
                let avatarColor = json!["avatarColor"].stringValue
                
                UserDataService.instance.setUserData(id: id, name: name, email: email, avatarName: avatarName, avatarcolor: avatarColor)
                completion(true)
                
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    
}
