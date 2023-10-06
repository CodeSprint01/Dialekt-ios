//
//  ChatVC + api.swift
//  Dialekt
//
//  Created by Techwin on 12/06/21.
//

import Foundation
import UIKit

extension ChatVC {
    
    //MARK:- API CALL FOR SEND MESSAGE
    
    func apiCallForSendingMessage(_ msg : String ){

        var params = [String: Any]()
        params = [
            "message":msg,
            "club_id":"\(self.ClubID)",
            "message_type": 0
        ]
        ApiManager.shared.Request(type: GeneralModel.self, methodType: .Post, url: BASE_URL + SEND_MESSAGE_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                PrintToConsole("response of send message \(String(describing: response))")
                self.apiCallForGetChat()
                DispatchQueue.main.async {
                    self.tfMessage.text = ""
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
    
    func apiCallForSendingfile(_ data : Data , fileType : FileType ) {
        var params = [String: Any]()
        var fileIs = 0
        if fileType == .Image {
            fileIs = 1
        }else if fileType == .Video {
            fileIs = 3
        }else if fileType == .Pdf {
            fileIs = 2
        }
        params = [
            "message":"",
            "club_id":"\(self.ClubID)",
            "message_type": fileIs
        ]
        ApiManager.shared.requestWithImage(type: GeneralModel.self, url: BASE_URL + SEND_MESSAGE_API , parameter: params, imageNames: ["file"], images: [data]) { error, response, message, statusCode in
            if statusCode == 200 {
                PrintToConsole("response of send file \(fileType) \(String(describing: response))")
                self.apiCallForGetChat()
                DispatchQueue.main.async {
                    self.tfMessage.text = ""
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
    
    //MARK: - API CALL FOR GET CHAT
    func apiCallForGetChat(){

        var params = [String: Any]()
        params = [
            "club_id":"\(self.ClubID)"
        ]
        ApiManager.shared.Request(type: WholeChatModel.self, methodType: .Post, url: BASE_URL + MESSAGE_LISTING_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if response?.data != nil {
                PrintToConsole("response of whole chat message api \(String(describing: response))")
                DispatchQueue.main.async {
                self.wholeChat = response?.data ?? []
                self.tableView.scrollToBottom()
                self.setupTable()
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
    
    
    
    
}


