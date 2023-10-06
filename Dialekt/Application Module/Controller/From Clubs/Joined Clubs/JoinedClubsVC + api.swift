//
//  JoinedClubsVC + api.swift
//  Dialekt
//
//  Created by Vikas saini on 31/05/21.
//

import Foundation
import UIKit

extension JoinedClubsVC  {
    
    //MARK:- API CALL FOR GETTING ALL MY CLUBS
    
    func apiCallForGettingAllMyClubs(){
        DispatchQueue.main.async {
        startAnimating(self.view)
        }
        let params = [String: Any]()
        ApiManager.shared.Request(type: MyClubsModel.self, methodType: .Get, url: BASE_URL + MY_CLUBS_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if let data = response?.data {
                    PrintToConsole("response of user_club_Listing api \(data)")
                    self.myAllClubsArray = data
                   
                    DispatchQueue.main.async {
                        self.numberOfClubsLabel.text = "\(data.count) Clubs"
                        self.tableView.dataSource = self
                        self.tableView.delegate = self
                        self.tableView.reloadData()
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
