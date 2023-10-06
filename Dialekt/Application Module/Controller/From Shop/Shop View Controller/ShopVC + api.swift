//
//  ShopVC + api.swift
//  Dialekt
//
//  Created by Techwin on 17/06/21.
//

import Foundation

extension ShopVC {
    
    //MARK:- API CALL FOR SHOP ITEMS LISTING

func apiCallForShopItemListing(){
   
    DispatchQueue.main.async {
    startAnimating(self.view)
    }
    let params = [String: String]()
   
    ApiManager.shared.Request(type: ListShopItemsModel.self, methodType: .Get, url: BASE_URL + LIST_SHOP_ITEMS_API , parameter: params) { (error, response, message, statusCode) in
        if statusCode == 200 {
            PrintToConsole("response of Join SHOP ITEMS LISTING api \(String(describing: response))")
            if (response?.data) != nil {
            self.shopItems = response?.data ?? []
                DispatchQueue.main.async {
                    self.setupCollection()
                }
            } else {
                Toast.show(message: DATA_NOT_FOUND, controller: self)
            }
            
        }else {
            if let msgStr = message {
                Toast.show(message: msgStr, controller: self)
            } else {
                Toast.show(message: SOMETHING_WENT_WRONG, controller: self)
            }
        }
    }
  }
}
