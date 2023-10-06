//
//  CreateGroupModel.swift
//  Dialekt
//
//  Created by Techwin on 01/07/21.
//

import Foundation

// MARK: - CreateGroupModel
struct CreateGroupModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: CreateGroupModelDataClass?
}

struct CreateGroupModelDataClass: Codable {
    let groupCode: String?
    let createdBy, groupMember: Int?
    let gameID, updatedAt, createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case groupCode = "group_code"
        case createdBy = "created_by"
        case groupMember = "group_member"
        case gameID = "game_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}

