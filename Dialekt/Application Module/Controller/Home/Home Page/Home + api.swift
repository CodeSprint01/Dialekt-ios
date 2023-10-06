//
//  Home + api.swift
//  Dialekt
//
//  Created by Vikas saini on 28/05/21.
//

import Foundation
import UIKit


extension HomeViewController {
    
 
    //MARK:- API CALL FOR LOGOUT
    
    func apiCallForLogout(){
        DispatchQueue.main.async {
        startAnimating(self.view)
        }
        let params = [String: Any]()
      
        ApiManager.shared.Request(type: GeneralModel.self, methodType: .Post, url: BASE_URL + LOGOUT_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                PrintToConsole("response of logout api \(String(describing: response))")
                    DispatchQueue.main.async {
                        let domain = Bundle.main.bundleIdentifier!
                        UserDefaults.standard.removePersistentDomain(forName: domain)
                        UserDefaults.standard.synchronize()
                        self.goToFirstPage()
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
    
    
    //MARK:- API CALL FOR GET USER LANGUAGE
    
    func apiCallForGetUserLanguage(){
        
        let params = [String: Any]()
        ApiManager.shared.Request(type: UserLanguagesModel.self, methodType: .Get, url: BASE_URL + GET_USER_LANGUAGES_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                PrintToConsole("response of Get user languages api \(String(describing: response))")
                if let data = response?.data {
                    self.allLanguagesData = data
                    DispatchQueue.main.async {
                        for aLang in data {
                            if aLang.language_type == UserDefaults.standard.string(forKey: UD_USERLANGUAGE) {
                                self.topRightImage.sd_setImage(with: URL(string: IMAGE_BASE_URL + (aLang.flag ?? "")), placeholderImage: #imageLiteral(resourceName: "city"), options: [.highPriority], context: nil)
                                break
                            }
                        }
                        self.setupCollectionView()
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
    
    //MARK:- API CALL FOR GET USER LANGUAGE
    
    func apiCallForChangeUserLanguage(_ lang : String){
        
        var params = [String: Any]()
        params = [
            "language":lang
        ]
        ApiManager.shared.Request(type: ChangeLanguagesModel.self, methodType: .Post, url: BASE_URL + CHANGE_USER_LANGUAGES_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                PrintToConsole("response of Get user languages api \(String(describing: response))")
                if let data = response?.data {
                    UserDefaults.standard.set(data.language ?? "", forKey: UD_USERLANGUAGE)
                    DispatchQueue.main.async {
                        self.topRightImage.sd_setImage(with: URL(string: IMAGE_BASE_URL + (data.flag ?? "")), placeholderImage: #imageLiteral(resourceName: "city"), options: [.highPriority], context: nil)
                        self.apiCallForGetUserLanguage()
                        self.LanguageSectionBlackViewClicked()
                        if let vc = R.storyboard.home.homeLevelsViewController() {
                            self.addChildView(viewControllerToAdd: vc, in: self.ContainerView1)
                        }
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
    
    
    
    //MARK:- API CALL FOR UPDATE PROFILE
    
    func apicallForupdateProfile(dict: [String:Any] ,image:UIImage , imageName: String = "image"){
        let data = self.personImageView.image != UIImage(named: "DummyUser") ? image.resized(withPercentage: 0.2)?.pngData() : image.pngData()
        ApiManager.shared.requestWithImage(type: LoginModel.self, url: BASE_URL + UPDATE_PROFILE_API, parameter: dict, imageNames: [imageName], images: [data!], completion: { (error, response, message, statusCode) in

               if statusCode == 200 {
                   if let data = response?.data {
                       PrintToConsole("response of get profile api \(data)")
                       DispatchQueue.main.async {
                           UserDefaults.standard.set(data.name ?? "", forKey: UD_NAME)
                           UserDefaults.standard.set(data.email ?? "", forKey: UD_EMAIL)
                           UserDefaults.standard.set(data.image ?? "", forKey: UD_USERIMAGE)
                           self.personNameLabel.text = data.name ?? ""
                           self.personImageView.tintColor = .darkGray
                           self.personImageView.sd_setImage(with: URL(string: IMAGE_BASE_URL + (UserDefaults.standard.string(forKey: UD_USERIMAGE) ?? "")), placeholderImage: #imageLiteral(resourceName: "DummyUser"), options: [.highPriority], context: nil)
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
           })
    }
    
    

}
