//
//  Signup + api.swift
//  Dialekt
//
//  Created by Techwin on 12/06/21.
//

import Foundation

extension SignViewController {
    
    
    //MARK: - API CALL FOR REGISTERATION
    
    func apiCallForRegistration(_ email : String , password : String , city : String , language : String , name : String ){
        DispatchQueue.main.async {
        startAnimating(self.view)
        }
        var params = [String: Any]()
        params = [
                "name":name,
                "email":email,
                "city":city,
                "dailect":language,
                "dailect_level":"Intermediate",
                "device_type":DEVICE_TYPE,
                "device_token":DEVICE_TOKKEN,
                "password":password
        ]
        ApiManager.shared.Request(type: LoginModel.self, methodType: .Post, url: BASE_URL + REGISTRATION_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if let data = response?.data {
                    PrintToConsole("response of signup api \(data)")
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
}
