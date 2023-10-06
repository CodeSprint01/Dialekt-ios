//
//  AllUserListModel.swift
//  Dialekt
//
//  Created by Techwin on 12/06/21.
//

import Foundation


// MARK: - AllUserListings
struct AllUserListings: Codable {
    let statusCode: Int?
    let message: String?
    let data: AllUserListingsDataClass?
}

// MARK: - DataClass
struct AllUserListingsDataClass: Codable {
    let currentPage: Int?
    let data: [LoginModelDataClass]?
    let firstPageURL: String?
    let from, lastPage: Int?
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



// MARK: - AllUserListingModel
struct GroupWiseUserListing: Codable {
    let statusCode: Int?
    let message: String?
    let data: [GroupWiseUserListingDataClass]?
}

// MARK: - Datum
struct GroupWiseUserListingDataClass: Codable {
    let userID: Int?
    let gameID, name, email, image: String?
    let city, dailect, dailectLevel: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case gameID = "game_id"
        case name, email, image, city, dailect
        case dailectLevel = "dailect_level"
    }
}
