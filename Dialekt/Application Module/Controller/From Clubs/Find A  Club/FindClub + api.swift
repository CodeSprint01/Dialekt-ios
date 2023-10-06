//
//  FindClub + api.swift
//  Dialekt
//
//  Created by Techwin on 12/06/21.
//

import Foundation

extension FindAClubVC {
    
    
    
    //MARK:- API CALL FOR ALL CLUB LISTING
    
    func apiCallForAllClubListing(){
      
        DispatchQueue.main.async {
        startAnimating(self.view)
        }
        let params = [String: String]()
        ApiManager.shared.Request(type: AllClubListing.self, methodType: .Get, url: BASE_URL + ALL_CLUB_LISTING_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if let data = response?.data {
                    PrintToConsole("response of Get all club listing data api \(data)")
                    DispatchQueue.main.async {
                        self.allClubs = data
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
    

    //MARK:- API CALL FOR JOIN CLUB

func apiCallForJoinClub(_ joiningCode : String ){
   
    DispatchQueue.main.async {
    startAnimating(self.view)
    }
    var params = [String: Any]()
    params = [
        "club_code" : joiningCode,
    ]
    ApiManager.shared.Request(type: GeneralModel.self, methodType: .Post, url: BASE_URL + JOIN_CLUB_FROM_CLUB_CODE_API, parameter: params) { (error, response, message, statusCode) in
        if statusCode == 200 {
            PrintToConsole("response of Join club api \(String(describing: response))")
                DispatchQueue.main.async {
                    //Notification will fire and this view will dismiss
                    NotificationCenter.default.post(name: NSNotification.Name.init("showJoined"), object: nil)
                    self.navigationController?.popViewController(animated: true)
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
