//
//  Constants.swift
//  Dialekt
//
//  Created by Vikas saini on 06/05/21.
//

import Foundation
import UIKit

let MainColor = UIColor(displayP3Red: 221/255, green: 101/255, blue: 67/255, alpha: 1.0)
let GreenColor = UIColor(displayP3Red: 40/255, green: 137/255, blue: 37/255, alpha: 1.0)
let GrayColor = UIColor(displayP3Red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)


//MARK:- CONSTANTS
let SOMETHING_WENT_WRONG = "Something went wrong!"
let DATA_NOT_FOUND = "No Data Found !"
let NO_RECORD_FOUND = "No Record Found"

//MARK:- DEVICE TYPE . DEVICE TOKEN
let DEVICE_TYPE = "1"
var DEVICE_TOKKEN = "12345678"

//MARK:- USER DEFAUTLS
let UD_TOKEN = "UD_TOKEN"
let UD_EMAIL = "UD_EMAIL"
let UD_USERIMAGE = "UD_USERIMAGE"
let UD_USERLANGUAGE = "UD_USERLANGUAGE"
let UD_NAME = "UD_NAME"
let UD_USERID = "UD_USERID"
let UD_DAILYGOAL = "UD_DAILYGOAL"
let UD_LOGGEDIN = "UD_LOGGEDIN"


//MARK:- STRIPE
let STRIPE_KEY = "pk_test_a77G5Og1kVs9qxSSoJINwmYr"

//MARK:- BASE URL
//let BASE_URL = "http://dbt.teb.mybluehostin.me/dailket/api/"
//let IMAGE_BASE_URL = "http://dbt.teb.mybluehostin.me/dailket/storage/app/public/"
//https://dialekt.iapplabz.co.in/assets/images/group.png

let BASE_URL = "https://dialekt.iapplabz.co.in/api/"
let IMAGE_BASE_URL = "https://dialekt.iapplabz.co.in/storage/app/public/"
let UPDATED_IMAGE_BASE_URL = "https://dialekt.iapplabz.co.in/assets/images/"


//MARK:- API END POINDS
let LOGIN_API = "login" //POST//1
let GET_PROFILE_API = "get_profile"//POST//2
let CHANGE_PASSWORD_API = "change_password"//POST//3
let UPDATE_PROFILE_API = "update_profile"//MULTIPART//4
let LOGOUT_API = "logout"//POST //5
let SEND_RESET_PASSWORD_LINK_API = "send-reset-link"//POST//6
let JOIN_CLUB_FROM_CLUB_CODE_API = "join_club"//POST//7
let CREATE_CLUB_API = "create_club"//POST//MULTIPART//8
let MY_CLUBS_API = "user_club_listing"//GET//9
let GET_CITIES_API = "get_city"//GET//10
let GET_LANGUAGE_API = "get_language"//GET//11
let GET_HOME_PAGE_LEVEL_LISTING_API = "level_lisiting"//POST//12
let ALL_CLUB_LISTING_API = "club_listing"//GET//13
let SEARCH_USERS_API = "search_user"//POST//14
let SEND_MESSAGE_API = "chat"//POST//15
let MESSAGE_LISTING_API = "message_listing"//GET//16
let REGISTRATION_API = "signup"//POST//17
let SOCIAL_LOGIN_API = "social_login"//POST//18
let UPDATE_CITY_AND_DIALEKT_API = "save_cty"//POST//19
let LIST_SHOP_ITEMS_API = "token_lisiting"//POST//20
let GET_USER_LANGUAGES_API = "get_user_language"//GET//21
let CHANGE_USER_LANGUAGES_API = "user_language"//POST//22
let GET_QUESTION_LISTING_API = "question_lisiting_new"//POST//23
let CREATE_GROUP_API = "create_group"//POST//24
let JOIN_GROUP_API = "join_group"//POST//25
let UPDATE_DAILY_GOAL_API = "updatedailygoal"//POST//26
let GET_DAILY_STREAK_API = "streak_listing"//GET //27
let BUY_TOKEN_API = "buy_token" //POST //28
let GAME_LISTING_API = "game_lisiting_new"//POST //29 
let SEARCH_USER_FOR_GROUP_API = "user_search_for_group"//GET //30
let PLAY_GAME_API = "play_game" //POST //31
let COMPLETE_LEVEL_API = "completeLevel"//POST //32
let GET_MY_GAME_POINTS_API = "get_point" //POST //33
let GET_OTHER_USERS_GAME_POINTS_API = "get_other_user_point"//POST // 34
let GET_GAME_LISTING_BY_GROUP_API = "game_lisiting_by_group"//POST //35
let GET_ALL_USER_POINT_API = "get_all_user_point"//POST //36
let QUIZ_QUESTIONS_API = "quiz_listing"//POST//37
let CLUB_DETAILS_API = "club-detail"
let CLUB_PROFILE_IMAGE_UPDATE_API = "update-club"
let REMOVE_MEMBER_FROM_CLUB = "remove-club-member"


class Credentials {
    static let PrivacyPolicyURL     = "https://dialekt.iapplabz.co.in/privacy-policy"
    static let TermsAndConditionURL = "https://dialekt.iapplabz.co.in/term-condition"
    static let kGoogleSignInClientID = "328319051980-hfj8sd9c5n0e55i7aqpvq1779oemlobb.apps.googleusercontent.com"
}

struct Constant {
    static let beginnerText = "Beginner"
    static let intermediateText = "Intermediate"
    static let expertText = "Expert"
    static let OopsText = "Oops !"
    static let notBadtext = "Not Bad !"
    static let superbText = "Superb !"
    static let beginnerDescription = "No Worries!\nLearning is easy with us. Join us and enhance your vocabulary with our community."
    static let intermediateDescription = "Improve More!\nLearning is easy with us. Join us and enhance your vocabulary with our community."
    static let expertDescription = "Learn Something New!\nLearning is easy with us. Join us and enhance your vocabulary with our community."
    
}
