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
  
    //make variabe check if user registred or no
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
            if (response.error == nil)
            {
//
                
                // user traditional json swift
//                if let json = response.result.value as? Dictionary <String , Any >  {
//
//                    if let email = json["email"] {
//                        self.userEmail = email as!  String
//                    }
//
//                    if let token  = json["token"]{
//                        self.AuthToken = token as!  String
//                    }
//                }
//                // use swiftyjson
                guard let data = response.data else {return}
                 let json = try? JSON(data: data)
                self.userEmail = json!["email"].stringValue
                self.AuthToken = json!["token"].stringValue
                self.islogIn = true
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
        
        
        
    }
    
    
    
}
