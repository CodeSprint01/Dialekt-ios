//
//  PlayGame + api.swift
//  Dialekt
//
//  Created by Techwin on 06/08/21.
//

import Foundation
import UIKit

extension PlayGameVC {
    
    
    //MARK:- API CALL FOR MyPoints
    func apiCallForMyPoints(_ isLastQuestion : Bool = false){
        
        let params = [ "group_id":"\(groupID)",
                        "game_id":"\(gameID)"]
        
        ApiManager.shared.Request(type: MyGamePointModel.self, methodType: .Post, url: BASE_URL + GET_MY_GAME_POINTS_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if let data = response?.data?.first {
                    PrintToConsole("response of MyPoints api \(data)")
                    DispatchQueue.main.async {
                    if let totalQ = data.totalQuestion , let CorrectAns = data.correctAnswer {
                        self.myProgressView.progress = Float(CorrectAns)/Float(totalQ)
                        if isLastQuestion {
                            if let vc = R.storyboard.playGame.yourScoreVC() {
                                vc.FinalScore = CorrectAns.toString+"/"+totalQ.toString
                                vc.groupID = self.groupID
                                vc.gameID = self.gameID
                                vc.modalPresentationStyle = .overFullScreen
                                self.present(vc, animated: true, completion: nil)
                            }
                        }
                    }
                    }
                }
            } else {
                if isLastQuestion {
                if let msgStr = message {
                    Toast.show(message: msgStr, controller: self)
                }else {
                    Toast.show(message: SOMETHING_WENT_WRONG, controller: self)
                }
                }
            }
        }
    }
    
    //MARK:- API CALL FOR Other user points
    func apiCallForOtherUsersPoints(){
        
        let params = [ "group_id":"\(groupID)"]
        
        ApiManager.shared.Request(type: OtherUserGamePointsModel.self, methodType: .Post, url: BASE_URL + GET_OTHER_USERS_GAME_POINTS_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if let data = response?.data {
                    PrintToConsole("response of OtherUserGamePoints api \(data)")
                    self.OtherUserPointsData = data
                    self.setupUserTableView()
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
    
    
    
    //MARK:- API CALL FOR Other user points
    func apiCallForGetQuestionList(){
        startAnimating(self.view)
        let params = [ "group_id":"\(groupID)"]
        ApiManager.shared.Request(type: QuestionlistingModel.self, methodType: .Post, url: BASE_URL + GET_GAME_LISTING_BY_GROUP_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if let data = response?.data {
                    PrintToConsole("response of Questionlisting api \(data)")
                    self.allQuestionsData = data
                    self.setupAfterGettingData()
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
    
    func apiCallForSubmittingAnswer(_ QuestionID : String , answer : String , isLastQuestion : Bool = false){
        let params = [ "question_id":QuestionID,
                        "answer":answer,
                        "game_id":"\(self.gameID)" ,
                        "group_id": self.groupID]
        ApiManager.shared.Request(type: GeneralModel.self, methodType: .Post, url: BASE_URL + PLAY_GAME_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
               PrintToConsole("Question answer is submitted !")
                self.apiCallForMyPoints(isLastQuestion)
                self.apiCallForOtherUsersPoints()
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
