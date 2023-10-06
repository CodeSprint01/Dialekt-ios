//
//  Enums.swift
//  DummyProject
//
//  Created by Vikas saini on 26/01/21.
//

import Foundation
import StoreKit
import SwiftUI


//MARK:- ENUM FOR METHOD TYPE
enum MethodType : String {
    case Post = "POST"
    case Get = "GET"
    case Put = "PUT"
    case Patch = "PATCH"
    case Delete = "DELETE"
}

//CONTRIBUTED BY SHIV SINGH THAKUR DATED MARCH 27 2021
enum TextFieldsCategory: String{
    case Email = "Email"
    case Password = "Password"
}

//MARK:- RATING AN APPLICATION WITHIN APPLCIATION ( USED ON RATE US BUTTON)
enum AppStoreReviewManager {
  static func requestReview() {
    SKStoreReviewController.requestReview()
  }
}


enum SocialLoginType : String {
    case fb = "1"
    case google = "2"
    case apple = "3"
}


enum FileType : String {
    case Image = "image"
    case Video = "video"
    case Pdf = "pdf"
}


enum SettingOptions: Int, CaseIterable {
    
    case Account = 0
    case TermsAndConditions
    case PrivacyPolicy
    case RateUs
    case ShareOnSocialMedia
    case Logout
}


//MARK:- Make Viewcontrollers Objects
enum VC<T: UIViewController>: String {
    
    case settings = "Settings"
    case fromClubs = "FromClubs"
    func instantiateVC(_ presentationStyle: UIModalPresentationStyle? = nil) -> T {
        let storyboard = UIStoryboard(name: self.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
        if let presentationStyle = presentationStyle {
            vc.modalPresentationStyle = presentationStyle
        }
        return vc
    }
}
