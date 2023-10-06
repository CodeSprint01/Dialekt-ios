//
//  ForgotPassword + api.swift
//  Dialekt
//
//  Created by Vikas saini on 31/05/21.
//

import Foundation
import UIKit

extension ForgotPasswordViewController  {
    
    //MARK:- API CALL FOR SENDING RESET LINK
    
    func apiCallForSendingResetPasswordLink(_ email : String ){
        DispatchQueue.main.async {
        startAnimating(self.view)
        }
        var params = [String: Any]()
        params = [
            "email":email,
        ]
        ApiManager.shared.Request(type: GeneralModel.self, methodType: .Post, url: BASE_URL + SEND_RESET_PASSWORD_LINK_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
              
                PrintToConsole("response of send reset link api \(String(describing: response))")
                    DispatchQueue.main.async {
                        Toast.show(message: "You must have received a link on your email if this email address is registered with us. Please check.", controller: self)
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

