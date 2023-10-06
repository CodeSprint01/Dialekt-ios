//
//  Account + api.swift
//  Dialekt
//
//  Created by Vikas saini on 28/05/21.
//

import Foundation
import UIKit
import SDWebImage

extension AccountViewController {
   
    //MARK:- API CALL FOR GET PROFILE
    func apiCallForGetProfile() {
     DispatchQueue.main.async {startAnimating(self.view)}
        let params = [String: Any]()
        ApiManager.shared.Request(type: LoginModel.self, methodType: .Get, url: BASE_URL + GET_PROFILE_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if let data = response?.data {
                    PrintToConsole("response of get profile api \(data)")
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(data.name ?? "", forKey: UD_NAME)
                        UserDefaults.standard.set(data.email ?? "", forKey: UD_EMAIL)
                        UserDefaults.standard.set(data.image ?? "", forKey: UD_USERIMAGE)
                        self.tfName.text = data.name ?? ""
                        self.tfEmail.text = data.email ?? ""
                        self.personImageView.tintColor = .darkGray

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
    
    func apicallForupdateProfile(dict: [String:Any] ,image:UIImage , imageName: String = "image") {
        
        DispatchQueue.main.async {startAnimating(self.view)}
        let data = self.personImageView.image != UIImage(named: "DummyUser") ? image.resized(withPercentage: 0.2)?.pngData() : image.pngData()
        
        ApiManager.shared.requestWithImage(type: LoginModel.self, url: BASE_URL + UPDATE_PROFILE_API, parameter: dict, imageNames: [imageName], images: [data!], completion: { (error, response, message, statusCode) in

               if statusCode == 200 {
                   if let data = response?.data {
                       PrintToConsole("response of get profile api \(data)")
                       DispatchQueue.main.async {
                           UserDefaults.standard.set(data.name ?? "", forKey: UD_NAME)
                           UserDefaults.standard.set(data.email ?? "", forKey: UD_EMAIL)
                           UserDefaults.standard.set(data.image ?? "", forKey: UD_USERIMAGE)
                           self.tfName.text = data.name ?? ""
                           self.tfEmail.text = data.email ?? ""
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
