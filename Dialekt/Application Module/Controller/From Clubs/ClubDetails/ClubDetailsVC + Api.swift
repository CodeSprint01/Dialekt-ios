//
//  ClubDetailsVC + Api.swift
//  Dialekt
//
//  Created by iApp on 24/08/22.
//

import UIKit

extension ClubDetailsVC {
    
    func apiGetClubDetails() {
        
        DispatchQueue.main.async {
            startAnimating(self.view)
        }
        
        guard let id = clubModel?.clubID else {return}
        let param:[String: Any] = ["club_id": id]
        
        ApiManager.shared.Request(type: ClubDetailsModel.self, methodType: .Get, url: BASE_URL + CLUB_DETAILS_API, parameter: param) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if let data = response?.data {
                    PrintToConsole("response of Get all club listing data api \(data)")
                    DispatchQueue.main.async {
                        self.clubDetails = data
                        self.updateData()
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
    
    
    
    
    //MARK:- API CALL FOR JOIN CLUB
    
    func apiCallForJoinClub(_ joiningCode : String, completion: @escaping()->() = {}){
        
        DispatchQueue.main.async {
            startAnimating(self.view)
        }
        var params = [String: Any]()
        params = [
            "club_code" : joiningCode
        ]
        ApiManager.shared.Request(type: GeneralModel.self, methodType: .Post, url: BASE_URL + JOIN_CLUB_FROM_CLUB_CODE_API, parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                PrintToConsole("response of Join club api \(String(describing: response))")
                NotificationCenter.default.post(name: NSNotification.Name.init("showJoined"), object: nil)
                completion()
                Toast.show(message: (response?.message)!, controller: self)
            }else {
                if let msgStr = message {
                    completion()
                    Toast.show(message: msgStr, controller: self)
                }else {
                    Toast.show(message: SOMETHING_WENT_WRONG, controller: self)
                }
            }
        }
    }
    
    
    func apiRemoveMemberFromClub(clubID: Int, memberUserID: String, completion: @escaping()->() = {}) {
        
        DispatchQueue.main.async {
            startAnimating(self.view)
        }
        var params = [String: Any]()
        params = [
            "club_id" : clubID,  "user_id" : memberUserID
        ]
        ApiManager.shared.Request(type: GeneralModel.self, methodType: .Post, url: BASE_URL + REMOVE_MEMBER_FROM_CLUB, parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                PrintToConsole("response of Join club api \(String(describing: response))")
                completion()
                Toast.show(message: response?.message ?? "" , controller: self)
            }else {
                if let msgStr = message {
                    completion()
                    Toast.show(message: msgStr, controller: self)
                }else {
                    Toast.show(message: SOMETHING_WENT_WRONG, controller: self)
                }
            }
        }
    }
    
    
    func apiUpdateClubImage(clubID: Int, image: UIImage) {
        DispatchQueue.main.async {
            startAnimating(self.view)
        }
        var params = [String: Any]()
        params = [
            "club_id" : clubID
        ]
        
        ApiManager.shared.requestWithImage(type: ClubDetailsModel.self, url: BASE_URL + CLUB_PROFILE_IMAGE_UPDATE_API, parameter: params, imageNames: ["image"], images: [image.pngData()!]) { [weak self] (error, response, message, statusCode)  in
            guard let self = self else {return}
               if statusCode == 200 {
                   if let data = response?.data {
                       PrintToConsole("response of get profile api \(data)")
                       DispatchQueue.main.async {
                           self.clubDetails = data
                           self.profileImageView.sd_setImage(with: URL(string: self.clubDetails?.image ?? ""), placeholderImage: UIImage(named: "clubPlaceholder"), options: [.highPriority], context: nil)
                       }
                       Toast.show(message: "Club Image updated successfully.", controller: self)
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
