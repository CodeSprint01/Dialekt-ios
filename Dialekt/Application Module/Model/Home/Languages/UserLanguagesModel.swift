//
//  UserLanguagesModel.swift
//  Dialekt
//
//  Created by Techwin on 21/06/21.
//

import Foundation


// MARK: - UserLanguagesModel
struct UserLanguagesModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: [UserLanguagesModelDataClass]?
}

// MARK: - Datum
struct UserLanguagesModelDataClass: Codable {
    let id: Int?
    let language:String?
    let language_type, flag, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, language_type, flag
        case language
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}



// MARK: - ChangeLanguagesModel
struct ChangeLanguagesModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: UserLanguagesModelDataClass?
}

