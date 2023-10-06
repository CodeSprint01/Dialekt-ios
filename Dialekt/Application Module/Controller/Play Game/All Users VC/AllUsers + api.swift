//
//  AllUsers + api.swift
//  Dialekt
//
//  Created by Techwin on 06/07/21.
//

import Foundation

extension AllUsersVC {
//MARK:- API CALL FOR ALL USER LIST

func apiCallForUserList(search: String,_ ShouldAnimate :Bool = true)
    {
        if ShouldAnimate{
            DispatchQueue.main.async {
                startAnimating(self.view)
            }
        }
    
    var params = [String: String]()
    params = [
        "search":search,
    ]
    
    ApiManager.shared.Request(type: GroupWiseUserListing.self, methodType: .Get, url: BASE_URL + SEARCH_USER_FOR_GROUP_API , parameter: params) { (error, response, message, statusCode) in
        
        if statusCode == 200 {
            if let data = response?.data {
                PrintToConsole("response of Get user list data api \(data)")
                DispatchQueue.main.async {
//
//                    for user in data {
//                    if !self.allUsers.contains(user) {
//                        self.allUsers.append(user)
//                    }
//                    }
                    self.allUsers = data
//                    self.total_pages = response?.data?.lastPage ?? 1
//                    self.current_page = response?.data?.currentPage ?? 1
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
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


