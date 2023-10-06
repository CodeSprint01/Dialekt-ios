//
//  JoinClub + api.swift
//  Dialekt
//
//  Created by Vikas saini on 31/05/21.
//

import Foundation
import UIKit

extension JoiningCodePopupVC {

    
    //MARK:- API CALL FOR JOIN CLUB

func apiCallForJoinClub(_ joiningCode : String ){
   
    DispatchQueue.main.async {
    startAnimating(self.view)
    }
    var params = [String: Any]()
    params = [
        "club_code" : joiningCode,
    ]
    ApiManager.shared.Request(type: GeneralModel.self, methodType: .Post, url: BASE_URL + JOIN_CLUB_FROM_CLUB_CODE_API , parameter: params) { (error, response, message, statusCode) in
        if statusCode == 200 {
            PrintToConsole("response of Join club api \(String(describing: response))")
                DispatchQueue.main.async {
                    //Notification will fire and this view will dismiss
                    NotificationCenter.default.post(name: NSNotification.Name.init("showJoined"), object: nil)
                    self.dismiss(animated: true, completion: nil)
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

