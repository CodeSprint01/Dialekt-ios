//
//  CreateOrJoin + Api.swift
//  Dialekt
//
//  Created by Techwin on 01/07/21.
//

import Foundation


extension CreateOrJoinGroupVC {
    
    //MARK:- API CALL FOR CREATE GROUP
    func apiCallForCreateGroup(){
        startAnimating(self.view)
        //game id is hardCoded there , should be changed later
        let stringIds = selectedUserIds.map { String($0) }.joined(separator: ",")
        let params = ["group_code": self.tfCreateGroupCode.text?.trimmed() ?? "" , "game_id" : "1" , "user_id" : stringIds]
        ApiManager.shared.Request(type: CreateGroupModel.self, methodType: .Post, url: BASE_URL + CREATE_GROUP_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if let data = response?.data {
                    PrintToConsole("response of CREATE GROUP api \(data)")
                    DispatchQueue.main.async {
                        self.CreatedGroupCode = self.tfCreateGroupCode.text?.trimmed() ?? ""
                        Toast.show(message: "Group Created Succuessfully", controller: self)
                        if let vc = R.storyboard.playGame.playGameVC(){
                            vc.groupID = String(data.id ?? 0)
                            vc.gameID = data.gameID ?? ""
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
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
    
    //MARK:- API CALL FOR JOIN GROUP
    func apiCallForJoinGroup(){
     DispatchQueue.main.async {startAnimating(self.view)}
        let params = ["group_code": self.tfEnterGroupJoiningCode.text?.trimmed() ?? ""]
        ApiManager.shared.Request(type: JoinGroupModel.self, methodType: .Post, url: BASE_URL + JOIN_GROUP_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if let data = response?.data {
                    PrintToConsole("response of JOin GROUP api \(data)")
                    DispatchQueue.main.async {
                        if let vc = R.storyboard.playGame.playGameVC(){
                            vc.groupID = String(data.groupID ?? 0)
                            vc.gameID = String(data.gameID ?? 0)
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
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
