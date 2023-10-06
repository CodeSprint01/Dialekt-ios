//
//  JoinGroupModel.swift
//  Dialekt
//
//  Created by Techwin on 02/08/21.
//

import Foundation
// MARK: - DailyStreakModel
struct JoinGroupModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: JoinGroupModelDataClass?
}

// MARK: - JoinGroupModelDataClass
struct JoinGroupModelDataClass: Codable {
    let groupID: Int?
    let createdBy: String?
    let userID, gameID: Int?
    let updatedAt, createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case groupID = "group_id"
        case createdBy = "created_by"
        case userID = "user_id"
        case gameID = "game_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
