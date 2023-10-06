//
//  OtherUserGamePointsModel.swift
//  Dialekt
//
//  Created by Techwin on 06/08/21.
//

import Foundation

// MARK: - OtherUserGamePointsModel
struct OtherUserGamePointsModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: [OtherUserGamePointsModelDataClass]?
}

// MARK: - Datum
struct OtherUserGamePointsModelDataClass: Codable {
    let id: Int?
    let groupID, userID, totalQuestion, correctAnswer: String?
    let createdAt, updatedAt, point, name: String?
    let email, image, city, dailect: String?

    enum CodingKeys: String, CodingKey {
        case id
        case groupID = "group_id"
        case userID = "user_id"
        case totalQuestion = "total_question"
        case correctAnswer = "correct_answer"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case point, name, email, image, city, dailect
    }
}
