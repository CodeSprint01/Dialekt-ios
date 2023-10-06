//
//  AllDailektModel.swift
//  Dialekt
//
//  Created by Vikas saini on 03/06/21.
//

import Foundation

// MARK: - AllDailektsModel
struct AllDailektsModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: AllDailektsModelDataClass?
}

// MARK: - DataClass
struct AllDailektsModelDataClass: Codable {
    let currentPage: Int?
    let data: [ParticularLanguageModel]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct ParticularLanguageModel: Codable, Equatable {
    let id: Int?
    let languageType, country, flag, updatedAt: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case languageType = "language_type"
        case country, flag
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

func ==(lhs: ParticularLanguageModel , rhs: ParticularLanguageModel) -> Bool
{
    return lhs.id == lhs.id && lhs.languageType == rhs.languageType
}
