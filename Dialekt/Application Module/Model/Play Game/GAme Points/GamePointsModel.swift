//
//  GamePointsModel.swift
//  Dialekt
//
//  Created by Techwin on 06/08/21.
//

import Foundation
// MARK: - MyGamePointModel
struct MyGamePointModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: [MyGamePointModelDataClass]?
}

// MARK: - MyGamePointModelDataClass
struct MyGamePointModelDataClass: Codable {
    let groupID: String?
    let totalQuestion, correctAnswer, point: Int?

    enum CodingKeys: String, CodingKey {
        case groupID = "group_id"
        case totalQuestion = "total_question"
        case correctAnswer = "correct_answer"
        case point
    }
}
