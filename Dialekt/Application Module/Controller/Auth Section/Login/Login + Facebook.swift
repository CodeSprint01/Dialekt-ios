//
//  Login + Facebook.swift
//  Dialekt
//
//  Created by Techwin on 13/05/21.
//

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit

extension LoginViewController {
    
    
    //MARK:- FACEBOOK LOGIN FUNCTION
    func facebookLogin(){
        if(AccessToken.current == nil ) {
            loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
                if ((result?.isCancelled)!) {
                }
                else {
                    if (error == nil) {
                        let params = ["fields" : "id, name, first_name, last_name, picture.type(large), email "]
                        let graphRequest = GraphRequest.init(graphPath: "/me", parameters: params)
                        let Connection = GraphRequestConnection()
                       // ApplicationDelegate.initializeSDK(nil) //koti
                        Connection.add(graphRequest) { (Connection, result, error) in
                            guard result != nil else {
                                Toast.show(message: "Error \(error?.localizedDescription ?? "")", controller: self)
                                return
                            }
                            let info = result as! [String : AnyObject]
                            let picDict = info["picture"] as? [String : Any ]
                            let dataDict = picDict!["data"] as! [String:Any]
                            
                            let _ = dataDict["url"] as? String
                            let fName = info["first_name"] as? String ?? ""
                            let lName = info["last_name"] as? String ?? ""
                            
                            let id = info["id"] as? String ?? ""
                            let email = info["email"] as? String ?? ""
                            self.apiCallForSocailLogin(email, name: fName + " " + lName, socialid: id, social_type: SocialLoginType.fb.rawValue)

                        }
                        Connection.start()
                    }
                }
                if let error = error {
                    let alertController = UIAlertController(title: "Message", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
        }else {
            loginManager.logOut()
            let alertController = UIAlertController(title: "Message", message: "Logged Out", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
