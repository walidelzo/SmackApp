import Foundation

typealias completionHandler = (_ Success :Bool ) ->()

///Segues

let TO_LOGIN = "toLogin"
let TO_CREATEACOUNT = "toCreateAccount"
let TO_WIND_TO_CHANNEL_SEGUE = "unWindToChannelSegue"

// User Defualts
let  TOKEN_KEY = "token"
let LOGED_IN_KEY = "logedIn"
let USER_EMAIL_KEY = "userEmail"

// URl

let BASE_URL = "https://walidsmackapp.herokuapp.com/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"

///JSON Header

let HEADER = ["Content-Type" : "application/json; charset=utf-8"]


