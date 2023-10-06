//
//  LevelResult + api.swift
//  Dialekt
//
//  Created by Techwin on 03/08/21.
//

import Foundation

extension LevelResultVC {
    
    //MARK:- API CALL FOR Complete Level
    func apiCallForLevelComplete(){
        startAnimating(self.view)
        let params = [ "game_id" : "\(GameID)" ]
        ApiManager.shared.Request(type: CompleteLevelModel.self, methodType: .Post, url: BASE_URL + COMPLETE_LEVEL_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if let data = response?.data {
                    PrintToConsole("response of Complete level api \(data)")
                    DispatchQueue.main.async {
                        self.labelForLevelPoints.text = String(data.levelPoint ?? 0)
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
    
    
}
