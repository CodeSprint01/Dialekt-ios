//
//  WholeChatModel.swift
//  Dialekt
//
//  Created by Techwin on 17/06/21.
//

import Foundation

// MARK: - WholeChatModel
struct WholeChatModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: [WholeChatModelDataClass]?
}

// MARK: - Datum
struct WholeChatModelDataClass: Codable {
    let id: Int
    let clubID, userID, message: String?
    let file: String?
    let messageType: Int?
    let image : String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case clubID = "club_id"
        case userID = "user_id"
        case message, file
        case messageType = "message_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case image
    }
}

