//
//  DailyGoalParam + api.swift
//  Dialekt
//
//  Created by Techwin on 30/07/21.
//

import Foundation
import UIKit

extension DailyGoalParameterVC {
    
    
    //MARK:- API CALL FOR SEND MESSAGE
    
    func apiCallForUpdatingDailyGoal(_ selection : String ){

        var params = [String: Any]()
        params = [
            "daily_goal":selection,
        ]
        
        ApiManager.shared.Request(type: GeneralModel.self, methodType: .Post, url: BASE_URL + UPDATE_DAILY_GOAL_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                PrintToConsole("response of UpdatingDailyGoal \(String(describing: response))")
                UserDefaults.standard.set(selection, forKey: UD_DAILYGOAL)
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
