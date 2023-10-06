//
//  MyClubsModel.swift
//  Dialekt
//
//  Created by Vikas saini on 31/05/21.
//

import Foundation

// MARK: - MyClubsModel
struct MyClubsModel: Codable {
    let statusCode: Int
    let message: String?
    let data: [MyClubsModelDataClass]?
}

// MARK: - Datum
struct MyClubsModelDataClass: Codable {
    let id: Int?
    let clubID, userID: String?
    let message, file: String?//file is non null when last message is not text
    let createdAt: String?//last message date and time
    let image: String?//club image
    let clubName: String?
    let messageType: Int? // 0 for text , 1 for other
    let user: LoginModelDataClass?//this user sent last message

    enum CodingKeys: String, CodingKey {
        case id
        case clubID = "club_id"
        case userID = "user_id"
        case message, file
        case createdAt = "created_at"
        case image
        case clubName = "club_name"
        case messageType = "message_type"
        case user
    }
}
