//
//  ClubDetails.swift
//  Dialekt
//
//  Created by iApp on 24/08/22.
//

import Foundation

// MARK: - Welcome
struct ClubDetailsModel: Codable {
    let statusCode: Int
    let message: String
    let data: ClubDetails
}

// MARK: - DataClass
struct ClubDetails: Codable {
    let id: Int
    let clubName, clubCode: String
    let image: String?
    let dataDescription, status, createdBy: String
    let totalMember: Int
    let clubMembers: [ClubMember]
    let adminName: String
    let isJoined: Bool
    let isCreater: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case clubName = "club_name"
        case clubCode = "club_code"
        case image
        case dataDescription = "description"
        case status
        case createdBy = "created_by"
        case totalMember = "total_member"
        case clubMembers = "club_members"
        case adminName = "admin_name"
        case isJoined = "is_join"
        case isCreater = "is_creater"
    }
}

// MARK: - ClubMember
struct ClubMember: Codable {
    let id: Int
    let clubID, userID, status, createdAt: String
    let updatedAt, memberName, memberEmail, memberImage: String

    enum CodingKeys: String, CodingKey {
        case id
        case clubID = "club_id"
        case userID = "user_id"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case memberName = "member_name"
        case memberEmail = "member_email"
        case memberImage = "member_image"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
