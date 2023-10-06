//
//  Pay + Api.swift
//  Dialekt
//
//  Created by Techwin on 02/08/21.
//

import Foundation


extension PayVC {
    
    //MARK:- API CALL FOR PAYMENT

    func apiCallForPayment(_ token : String){
   
    DispatchQueue.main.async {
    startAnimating(self.view)
    }
    let params = [
        "token_id":String(shopItem?.id ?? 0) ,
        "price":Int(shopItem?.price ?? "0") ?? 0 ,
        "stripeToken":token
    ] as [String : Any]
   
    ApiManager.shared.Request(type: GeneralModel.self, methodType: .Post, url: BASE_URL + BUY_TOKEN_API , parameter: params) { (error, response, message, statusCode) in
        if statusCode == 200 {
            PrintToConsole("response of Paymentapi \(String(describing: response))")
            Toast.show(message: "Payment is Successfull", controller: self)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.navigationController?.popViewController(animated: true)
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

