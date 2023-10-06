//
//  AllClubListingModel.swift
//  Dialekt
//
//  Created by Techwin on 12/06/21.
//

import Foundation
import SwiftUI

// MARK: - AllClubListing
struct AllClubListing: Codable {
    let statusCode: Int?
    let message: String?
    let data: [AllClubListingDataClass]?
}

// MARK: - Datum
struct AllClubListingDataClass: Codable {
    let clubName, clubCode: String?
    let image: String?
    let datumDescription: String?
    let total, clubID: Int?
    let user: [LoginModelDataClass]?

    enum CodingKeys: String, CodingKey {
        case clubName = "club_name"
        case clubCode = "club_code"
        case image
        case datumDescription = "description"
        case total, user
        case clubID = "club_id"
    }
}

