//
//  SelectDailekt + api.swift
//  Dialekt
//
//  Created by Vikas saini on 03/06/21.
//

import Foundation
import UIKit
import SDWebImage

extension SelectDialectViewController {
    
    //MARK:- API CALL FOR CITY LIST
    
    func apiCallForDailetList(search: String , Page: Int , _ ShouldAnimate :Bool = false)
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
        
        ApiManager.shared.Request(type: AllDailektsModel.self, methodType: .Get, url: BASE_URL + GET_LANGUAGE_API , parameter: params) { (error, response, message, statusCode) in
            
            if statusCode == 200 {
                if let data = response?.data?.data {
                    PrintToConsole("response of Get Cities data api \(data)")
                    DispatchQueue.main.async {
                        if Page == 1 {
                            self.allCitiesData.removeAll()
                        }
                        for city in data {
                        if !self.allCitiesData.contains(city) {
                            self.allCitiesData.append(city)
                        }
                        }
                        self.total_pages = response?.data?.lastPage ?? 1
                        self.current_page = response?.data?.currentPage ?? 1
                        self.CollectionView.delegate = self
                        self.CollectionView.dataSource = self
                        self.CollectionView.reloadData()
                    }
                } else {
                    Toast.show(message: DATA_NOT_FOUND, controller: self)
                }
            } else {
                if let msgStr = message {
                    Toast.show(message: msgStr, controller: self)
                }else {
                    Toast.show(message: SOMETHING_WENT_WRONG, controller: self)
                }
            }
        }
    }
    
    
    //MARK:- API CALL FOR UPDATE SELECTED CITY AND SELECTED DIALEKT
    
    func apiCallForUpdateCityAndDailekt(_ city : String , dailekt :String , userid: String){
        DispatchQueue.main.async {
        startAnimating(self.view)
        }
        var params = [String: Any]()
        params = [
            "user_id":userid,
            "city":city,
            "dailect":dailekt
           
        ]
        ApiManager.shared.Request(type: LoginModel.self, methodType: .Post, url: BASE_URL + UPDATE_CITY_AND_DIALEKT_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 || statusCode == 202 {
                if (response?.data) != nil {
                    if let data = self.socailLoggedInUserDetail {
                    UserDefaults.standard.set(true, forKey: UD_LOGGEDIN)
                    UserDefaults.standard.set(data.id ?? 0, forKey: UD_USERID)
                    UserDefaults.standard.set(data.name ?? "", forKey: UD_NAME)
                    UserDefaults.standard.set(data.email ?? "", forKey: UD_EMAIL)
                    UserDefaults.standard.set(data.image ?? "", forKey: UD_USERIMAGE)
                    UserDefaults.standard.set(data.token ?? "", forKey: UD_TOKEN)
                    UserDefaults.standard.set(data.dailect ?? "", forKey: UD_USERLANGUAGE)
                    DispatchQueue.main.async {
                        self.goTohomePage()
                    }
                    }else {
                        Toast.show(message: DATA_NOT_FOUND, controller: self)
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
    
    //MARK:- Go For Login
    func goTohomePage(){
        if let window = GetWindow(), let vc = R.storyboard.home.homeViewController() {
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        window.rootViewController = nav
        window.makeKeyAndVisible()
        }
    }



}
