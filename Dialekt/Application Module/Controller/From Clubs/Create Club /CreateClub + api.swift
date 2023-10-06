//
//  CreateClub + api.swift
//  Dialekt
//
//  Created by Vikas saini on 31/05/21.
//

import Foundation
import UIKit

extension CreateClubVC {
    
    
    //MARK:- API CALL FOR CREATE CLUB

    func apiCallForCreateClub(_ params : [String:Any] ){
    DispatchQueue.main.async {
    startAnimating(self.view)
    }
        ApiManager.shared.requestWithImage(type: GeneralModel.self, url: BASE_URL + CREATE_CLUB_API, parameter: params, imageNames: ["image"], images: [self.personImage.image!.pngData()!]) { (error, response, message, statusCode) in

        if statusCode == 200 {
            PrintToConsole("response of create club api \(String(describing: response))")
                DispatchQueue.main.async {
                    Toast.show(message: "Club Created.", controller: self)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.navigationController?.popViewController(animated: true)
                    }
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


    //MARK:- API CALL FOR ALL USER LIST
    
    func apiCallForUserList(search: String, Page: Int,_ ShouldAnimate :Bool = false)
        {
        if ShouldAnimate{
        DispatchQueue.main.async {
        startAnimating(self.view)
        }
        }
        
        var params = [String: String]()
        params = [
            "page":String(Page),
            "search":search,
        ]
        
        ApiManager.shared.Request(type: AllUserListings.self, methodType: .Get, url: BASE_URL + SEARCH_USERS_API , parameter: params) { (error, response, message, statusCode) in
            
            if statusCode == 200 {
                if let data = response?.data?.data {
                    PrintToConsole("response of Get user list data api \(data)")
                    DispatchQueue.main.async {
                        if Page == 1 {
                            self.allUsers.removeAll()
                        }
                        for user in data {
                        if !self.allUsers.contains(user) {
                            self.allUsers.append(user)
                        }
                        }
                        self.total_pages = response?.data?.lastPage ?? 1
                        self.current_page = response?.data?.currentPage ?? 1
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

