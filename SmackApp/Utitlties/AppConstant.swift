import Foundation

typealias completionHandler = (_ Success :Bool ) ->()

///Segues

let TO_LOGIN = "toLogin"
let TO_CREATEACOUNT = "toCreateAccount"
let TO_WIND_TO_CHANNEL_SEGUE = "unWindToChannelSegue"
let To_AVATAR_PICKER = "toAvatarPicker"

// User Defualts
let  TOKEN_KEY = "token"
let LOGED_IN_KEY = "logedIn"
let USER_EMAIL_KEY = "userEmail"

//Notification centre constant

let NOTIFY_USER_DATA_CHANGED = Notification.Name("notifUserDataChanged")
let NOTIFY_CHANNEL_LOADED = Notification.Name("notifichannelLoaded")
let NOTIFY_CHANNEL_SELECTED = Notification.Name("notifichannelSelected")





//let BASE_URL = "https://walidsmackapp.herokuapp.com/v1/"
let BASE_URL = "http://localhost:3005/v1/"

let REGISTER_URL = "\(BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"
let ADD_USER_URL = "\(BASE_URL)user/add"
let LOGIN_USER_BYID_URL = "\(BASE_URL)user/byEmail/"
let URL_CHANNEL = "\(BASE_URL)channel/"


///JSON Header

let HEADER = ["Content-Type" : "application/json; charset=utf-8"]

let BREARER_HEADER = [
    "Authorization" : "Bearer \(AuthService.instance.AuthToken)" ,
    "Content-Type" : "application/json; charset=utf-8"
]

