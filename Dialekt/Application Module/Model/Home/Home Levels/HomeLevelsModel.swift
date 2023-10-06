//
//  HomeLevelsModel.swift
//  Dialekt
//
//  Created by Techwin on 12/06/21.
//

import Foundation

// MARK: - HomeLevelsModel
struct HomeLevelsModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: [HomeLevelsModelDataClass]?
}

// MARK: - Datum
struct HomeLevelsModelDataClass: Codable {
    let id: Int
    let name, createdAt, updatedAt: String?
    let gameType: [GameType]?
 

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case gameType = "game_type"
     
    }
}

// MARK: - GameType
struct GameType: Codable {
    let id, levelID: Int?
    let gameName, createdAt, updatedAt: String?
    let point : Int?
    let isactive_count: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case levelID = "level_id"
        case gameName = "game_name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case point
        case isactive_count
    }
}
