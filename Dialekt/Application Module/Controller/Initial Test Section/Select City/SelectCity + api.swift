//
//  SelectCity + api.swift
//  Dialekt
//
//  Created by Vikas saini on 01/06/21.
//

import Foundation
import UIKit
import SDWebImage

extension SelectCityViewController {
    
    //MARK:- API CALL FOR CITY LIST
    
    func apiCallForCityList(search: String , Page: Int , _ ShouldAnimate :Bool = false)
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
        
        ApiManager.shared.Request(type: AllCitiesModel.self, methodType: .Get, url: BASE_URL + GET_CITIES_API , parameter: params) { (error, response, message, statusCode) in
            
            if statusCode == 200 {
                if let data = response?.data.data {
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
                        self.total_pages = response?.data.lastPage ?? 1
                        self.current_page = response?.data.currentPage ?? 1
                        self.CollectionView.delegate = self
                        self.CollectionView.dataSource = self
                        self.CollectionView.reloadData()
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
