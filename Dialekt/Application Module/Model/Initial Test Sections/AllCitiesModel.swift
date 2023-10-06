//
//  AllCitiesModel.swift
//  Dialekt
//
//  Created by Vikas saini on 01/06/21.
//

import Foundation


// MARK: - AllCitiesModel
struct AllCitiesModel: Codable {
    let statusCode: Int
    let message: String
    let data: AllCitiesModelDataClass
}

// MARK: - AllCitiesModelDataClass
struct AllCitiesModelDataClass: Codable {
    let currentPage: Int
    let data: [ParticularCityData]?
    let firstPageURL: String?
    let from, lastPage: Int
    let lastPageURL, nextPageURL, path: String?
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

// MARK: - ParticularCityData
struct ParticularCityData: Codable , Equatable {
    let id: Int
    let city, country, flag, created_at: String?
    let updated_at: String?
}

func ==(lhs: ParticularCityData , rhs: ParticularCityData) -> Bool
{
    return lhs.id == lhs.id && lhs.city == rhs.city
}
