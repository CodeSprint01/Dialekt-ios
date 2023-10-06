//
//  Home level  + api.swift
//  Dialekt
//
//  Created by Techwin on 12/06/21.
//

import Foundation

extension HomeLevelsViewController {
    
    
    //MARK:- API CALL FOR HOME LEVEL
    
    func apiCallForHomeLevel(){
      
        DispatchQueue.main.async {
        startAnimating(self.view)
        }
        var params = [String: Any]()
        params = ["language": UserDefaults.standard.string(forKey: UD_USERLANGUAGE) ?? ""]
        ApiManager.shared.Request(type: HomeLevelsModel.self, methodType: .Post, url: BASE_URL + GET_HOME_PAGE_LEVEL_LISTING_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if let data = response?.data {
                    PrintToConsole("response of Get HOME LEVEL data api \(data)")
                    DispatchQueue.main.async {
                        self.allHomeLevelData = data
                        self.setupTable()
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
