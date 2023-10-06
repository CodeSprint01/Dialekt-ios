//
//  QuestionlistingModel.swift
//  Dialekt
//  Created by Techwin on 23/06/21.
//

import Foundation

// MARK: - QuestionlistingModel
struct QuestionlistingModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: [QuestionlistingModelDataClass]?
}

// MARK: - Datum
struct QuestionlistingModelDataClass: Codable {
    
    let id, gameID: Int?
    let question, answer, type: String?
    let option: [Option]?
    let heading: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case gameID = "game_id"
        case question, answer, type, option, heading
    }
    
}

// MARK: - Option
struct Option: Codable {
    let option: String?
    let image: String?
}
