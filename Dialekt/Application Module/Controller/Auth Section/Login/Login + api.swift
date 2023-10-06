//
//  Login + api.swift
//  Dialekt
//
//  Created by Vikas saini on 28/05/21.
//

import Foundation
import UIKit

extension LoginViewController {
    
    //MARK:- API CALL FOR LOGIN
    
    func apiCallForLogin(_ email : String , password : String){
        DispatchQueue.main.async {
        startAnimating(self.view)
        }
        var params = [String: Any]()
        params = [
            "email":email,
            "device_type":DEVICE_TYPE,
            "device_token":DEVICE_TOKKEN,
            "password":password
        ]
        ApiManager.shared.Request(type: LoginModel.self, methodType: .Post, url: BASE_URL + LOGIN_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if let data = response?.data {
                    PrintToConsole("response of Login api \(data)")
                    UserDefaults.standard.set(true, forKey: UD_LOGGEDIN)
                    UserDefaults.standard.set(data.id ?? 0, forKey: UD_USERID)
                    UserDefaults.standard.set(data.name ?? "", forKey: UD_NAME)
                    UserDefaults.standard.set(data.email ?? "", forKey: UD_EMAIL)
                    UserDefaults.standard.set(data.image ?? "", forKey: UD_USERIMAGE)
                    UserDefaults.standard.set(data.token ?? "", forKey: UD_TOKEN)
                    UserDefaults.standard.set(data.dailect ?? "", forKey: UD_USERLANGUAGE)
                    UserDefaults.standard.set(data.daily_goal ?? "", forKey: UD_DAILYGOAL)
                    DispatchQueue.main.async {
                        self.goTohomePage()
                    }
                }else {
                    Toast.show(message: DATA_NOT_FOUND, controller: self)
                }
            }else {
                if let msgStr = message {
                    Toast.show(message: msgStr, controller: self)
                }else {
                    Toast.show(message: SOMETHING_WENT_WRONG, controller: self)
                }
            }
        }
    }
    
    
    //MARK:- API CALL FOR SOCIAL LOGIN
    
    func apiCallForSocailLogin(_ email : String , name : String , socialid : String , social_type: String){
        DispatchQueue.main.async {
        startAnimating(self.view)
        }
        var params = [String: Any]()
        params = [
            "email":email,
            "device_type":DEVICE_TYPE,
            "device_token":DEVICE_TOKKEN,
            "name":name,
            "social_id": socialid,
            "social_type":social_type
        ]
        
        ApiManager.shared.Request(type: LoginModel.self, methodType: .Post, url: BASE_URL + SOCIAL_LOGIN_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 202 {
                //this happen when UserSocial login for first time and did not select City and Dailekt
                if let vc = R.storyboard.initialTests.selectCityViewController() , let data = response?.data{
                    DispatchQueue.main.async {
                        vc.isFromSocialLogin = true
                        vc.socailLoggedInUserDetail = data
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }else if statusCode == 200 {
                if let data = response?.data {
                    PrintToConsole("response of socail Login api \(data)")
                    UserDefaults.standard.set(true, forKey: UD_LOGGEDIN)
                    UserDefaults.standard.set(data.id ?? 0, forKey: UD_USERID)
                    UserDefaults.standard.set(data.name ?? "", forKey: UD_NAME)
                    UserDefaults.standard.set(data.email ?? "", forKey: UD_EMAIL)
                    UserDefaults.standard.set(data.image ?? "", forKey: UD_USERIMAGE)
                    UserDefaults.standard.set(data.token ?? "", forKey: UD_TOKEN)
                    UserDefaults.standard.set(data.dailect ?? "", forKey: UD_USERLANGUAGE)
                    DispatchQueue.main.async {
                        self.goTohomePage()
                    }
                } else {
                    Toast.show(message: DATA_NOT_FOUND, controller: self)
                }
            }else {
                if let msgStr = message {
                    Toast.show(message: msgStr, controller: self)
                }else {
                    Toast.show(message: SOMETHING_WENT_WRONG, controller: self)
                }
            }
        }
    }
    
    

}
