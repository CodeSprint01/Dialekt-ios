//
//  Quiz + Api.swift
//  Dialekt
//
//  Created by Vikas Saini on 16/11/21.
//

import Foundation

extension QuizVC  {
    
    //MARK: - API CALL FOR Question LIST
    
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
        
        ApiManager.shared.Request(type: QuestionlistingModel.self, methodType: .Post, url: BASE_URL + QUIZ_QUESTIONS_API , parameter: params) { (error, response, message, statusCode) in
            
            if statusCode == 200 {
               
                if let data = response?.data {
                    self.allQuestionsData = data
                    PrintToConsole("response of Get Question Listing data api \(data)")
                    self.setupAfterGettingData()
                } else {
                    Toast.show(message: DATA_NOT_FOUND, controller: self)
                }
            } else {
                if let msgStr = message {
                    Toast.show(message: msgStr, controller: self)
                } else {
                    Toast.show(message: SOMETHING_WENT_WRONG, controller: self)
                }
            }
        }
    }
}
