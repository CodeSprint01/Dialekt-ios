//
//  Test Progress + api.swift
//  Dialekt
//
//  Created by Techwin on 25/06/21.
//

import Foundation


extension TestProgressVC  {
    
    
    //MARK:- API CALL FOR Question LIST
    
    func apiCallForQuestionList(){
      
        DispatchQueue.main.async {
        startAnimating(self.view)
        }
        var params = [String: String]()
        params = [
            "languages":selectedLanguage,
            "city":selectedCity,
            "level":selectedLevel
        ]
        
//        let params = ["id":"3"]
        ApiManager.shared.Request(type: QuestionlistingModel.self, methodType: .Post, url: BASE_URL + GET_QUESTION_LISTING_API , parameter: params) { (error, response, message, statusCode) in
            
            if statusCode == 200 {
               
                if let data = response?.data {
                    self.allQuestionsData = data
                    PrintToConsole("response of Get Question Listing data api \(data)")
                    self.setupAfterGettingData()
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
    
    
    //MARK:- API CALL FOR LEVEL Question LIST
    
    func apiCallForLevelQuestionList(){
      
        DispatchQueue.main.async {
        startAnimating(self.view)
        }
        let params = ["id":"\(self.gameId)"]
//        params = [
//            "languages":selectedLanguage,
//            "city":selectedCity,
//            "level":selectedLevel
//        ]
        
        ApiManager.shared.Request(type: QuestionlistingModel.self, methodType: .Post, url: BASE_URL + GAME_LISTING_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if let data = response?.data {
                    self.allQuestionsData = data
                    PrintToConsole("response of Get Level Question Listing data api \(data)")
                    self.setupAfterGettingData()
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
    
    
    //MARK:- API CALL FOR SUBMITTING ANSWER
    
    func apiCallForSubmittingAnswer(_ QuestionID : String , answer : String){
        let params = [ "question_id":QuestionID,
                        "answer":answer,
                        "game_id":"\(self.gameId)" ]
        ApiManager.shared.Request(type: GeneralModel.self, methodType: .Post, url: BASE_URL + PLAY_GAME_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
               PrintToConsole("Question answer is submitted !")
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
