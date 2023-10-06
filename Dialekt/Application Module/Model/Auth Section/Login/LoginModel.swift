//
//  LoginModel.swift
//  Dialekt
//
//  Created by Vikas saini on 28/05/21.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    let statusCode: Int
    let message: String?
    let data: LoginModelDataClass?
}

// MARK: - DataClass
struct LoginModelDataClass: Codable , Equatable {
    let id: Int?
    let name, email, image, city: String?
    let dailect, dailectLevel: String?
    let deviceToken: String?
    let emailVerifiedAt: String?
    let createdAt, updatedAt, token: String?
    let daily_goal :String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, image, city, dailect
        case dailectLevel = "dailect_level"
        case deviceToken = "device_token"
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case token
        case daily_goal
    }
}

func == (lhs: LoginModelDataClass , rhs: LoginModelDataClass) -> Bool {
    return lhs.id == rhs.id
}
