//
//  Login + GoogleSignin.swift
//  Dialekt
//
//  Created by Vikas saini on 13/05/21.
//

import Foundation
import GoogleSignIn


extension LoginViewController { //koti

    //MARK:- GOOGLE SIGN IN
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if (error == nil) {
//            if GIDSignIn.sharedInstance.currentUser != nil{
//                let name = user.profile?.name ?? "--"
//                let email = user.profile?.email ?? ""
//                let id  = user.userID!
//                //if  user.profile?.hasImage {}
//                self.apiCallForSocailLogin(email, name: name, socialid: id, social_type: SocialLoginType.google.rawValue)
//
//            }
//            else{
//                Toast.show(message: "Error While Google Sign in", controller: self, color: .red)
//            }
//        }
//        else {
//            print("\(error.localizedDescription)")
//        }
//    }

    func googleSignIn(viewController: UIViewController){
        //CHECKING INTERNET CONNECTIVTY
        guard Connectivity.isConnectedToInternet else {
            ApiManager.shared.callInternetAlert()
            return
        }
        GIDSignIn.sharedInstance.signOut()
        let signInConfig = GIDConfiguration.init(clientID: Credentials.kGoogleSignInClientID)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: viewController) { user, error in
            if (error == nil) {
                if GIDSignIn.sharedInstance.currentUser != nil{
                    let name = user?.profile?.name ?? "--"
                    let email = user?.profile?.email ?? ""
                    let id  = user?.userID!
                    //if  user.profile?.hasImage {}
                    self.apiCallForSocailLogin(email, name: name, socialid: id!, social_type: SocialLoginType.google.rawValue)
                    
                }
                else{
                    Toast.show(message: "Error While Google Sign in", controller: self, color: .red)
                }
            }
            else {
                print(error?.localizedDescription as Any)
            }
            
        }
    }
    
}
