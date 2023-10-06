//
//  CompleteLevelModel.swift
//  Dialekt
//
//  Created by Techwin on 03/08/21.
//

import Foundation



// MARK: - CompleteLevelModel
struct CompleteLevelModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: CompleteLevelModelDataClass?
}

// MARK: - DataClass
struct CompleteLevelModelDataClass: Codable {
    let gameID: String?
    let totalQuestion, correctAnswer, levelPoint: Int?

    enum CodingKeys: String, CodingKey {
        case gameID = "game_id"
        case totalQuestion = "total_question"
        case correctAnswer = "correct_answer"
        case levelPoint = "level_point"
    }
}
