//
//  ListShopItemsModel.swift
//  Dialekt
//
//  Created by Techwin on 17/06/21.
//

import Foundation
import UIKit

// MARK: - ListShopItemsModel
struct ListShopItemsModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: [ListShopItemsModelDataClass]?
}

// MARK: - Datum
struct ListShopItemsModelDataClass: Codable {
    let id: Int?
    let name, point, price, image: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, point, price, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
