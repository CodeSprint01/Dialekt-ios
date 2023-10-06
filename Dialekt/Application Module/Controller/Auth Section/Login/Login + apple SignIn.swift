//
//  Login + apple SignIn.swift
//  Dialekt
//
//  Created by Vikas saini on 13/05/21.
//

import Foundation
import AuthenticationServices



extension LoginViewController : ASAuthorizationControllerDelegate{
    
    @available(iOS 13.0, *)
    func handleAppleIdRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName?.givenName ?? ""
            let email = appleIDCredential.email ?? ""
//            let token = appleIDCredential.identityToken
//            let authCode = appleIDCredential.authorizationCode
//            let realUserStatus = appleIDCredential.realUserStatus
            PrintToConsole("Name and email for apple ID:-----\(String(describing: fullName)) \(String(describing: email)) \(userIdentifier)")
            // Toast.show(message: "Email \(String(describing: email)) with name \(String(describing: fullName))", controller: self)
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userIdentifier) {  (credentialState, error) in
                
                switch credentialState {
                case .authorized:
                    self.apiCallForSocailLogin(email, name: fullName, socialid: userIdentifier, social_type: SocialLoginType.apple.rawValue)
                    break
                case .revoked:
                    // The Apple ID credential is revoked.
                    Toast.show(message: "REVOKED", controller: self)
                    break
                case .notFound:
                    // No credential was found, so show the sign-in UI.
                    Toast.show(message: "NOT FOUND", controller: self)
                    break
                default:
                    break
                }
                
                //                case .authorized:
                //                    // The Apple ID credential is valid.
                //
                //                    if email != nil && fullName != nil {
                //                        self.apiCallForSocailLogin(email!, name: fullName?.nickname ?? "-", socialid: userIdentifier, social_type: SocialLoginType.apple.rawValue)
                //                    } else {
                //                        Toast.show(message: "No Email or Name found with apple account", controller: self)
                //                    }
                //                    break
                
                
            }
        }
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        Toast.show(message: error.localizedDescription, controller: self)
    }
}
