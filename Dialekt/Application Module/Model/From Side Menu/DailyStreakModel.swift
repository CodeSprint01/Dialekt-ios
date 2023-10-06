//
//  DailyStreakModel.swift
//  Dialekt
//
//  Created by Techwin on 30/07/21.
//

import Foundation



// MARK: - DailyStreakModel
struct DailyStreakModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: [DailyStreakModelDataClass]?
}

// MARK: - Datum
struct DailyStreakModelDataClass: Codable {
    let id: Int?
    let userID, gameID, createdAt, updatedAt: String?
    let date: String?
    let completeStreak: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case gameID = "game_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case date
        case completeStreak = "complete_streak"
    }
}
