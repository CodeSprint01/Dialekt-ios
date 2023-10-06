//
//  Reset Password + api.swift
//  Dialekt
//
//  Created by Vikas saini on 28/05/21.
//

import Foundation
import UIKit

extension ResetPasswordViewController {
    
    //MARK:- API CALL FOR CHANGE PASSWORD
    
    func apiCallForChangePassword(_ OLD : String , NEW : String){
        DispatchQueue.main.async {
        startAnimating(self.view)
        }
        var params = [String: Any]()
        params = [
           
                "password":OLD,
                "new_password":NEW,
                "confirm_password": NEW
           
        ]
        ApiManager.shared.Request(type: LoginModel.self, methodType: .Post, url: BASE_URL + CHANGE_PASSWORD_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                PrintToConsole("response of change password api \(String(describing: response))")
                    DispatchQueue.main.async {
                        if let vc = R.storyboard.settings.resetPasswordSuccessVC() {
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
              
            } else {
                if let msgStr = message {
                    Toast.show(message: msgStr, controller: self)
                }else {
                    Toast.show(message: SOMETHING_WENT_WRONG, controller: self)
                }
            }
        }
    }
}
