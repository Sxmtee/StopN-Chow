//
//  ProductModel.swift
//  StopN'Chow
//
//  Created by mac on 27/02/2025.
//

import SwiftUI

struct ProductModel: Decodable, Identifiable, Equatable {
    let id: Int
    let prodId: Int
    let catId: Int
    let brandId: Int
    let typeId: Int
    let detail: String
    let name: String
    let unitName: String
    let unitValue: String
    let nutritionWeight: String
    let image: String
    let catName: String
    let typeName: String
    let offerPrice: Double?
    let price: Double
    let startDate: Date
    let endDate: Date
    let isFav: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case prodId = "prod_id"
        case catId = "cat_id"
        case brandId = "brand_id"
        case typeId = "type_id"
        case detail
        case name
        case unitName = "unit_name"
        case unitValue = "unit_value"
        case nutritionWeight = "nutrition_weight"
        case image
        case catName = "cat_name"
        case typeName = "type_name"
        case offerPrice = "offer_price"
        case price
        case startDate = "start_date"
        case endDate = "end_date"
        case isFav = "is_fav"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        prodId = try container.decodeIfPresent(Int.self, forKey: .prodId) ?? 0
        catId = try container.decodeIfPresent(Int.self, forKey: .catId) ?? 0
        brandId = try container.decodeIfPresent(Int.self, forKey: .brandId) ?? 0
        typeId = try container.decodeIfPresent(Int.self, forKey: .typeId) ?? 0
        
        detail = try container.decodeIfPresent(String.self, forKey: .detail) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        unitName = try container.decodeIfPresent(String.self, forKey: .unitName) ?? ""
        unitValue = try container.decodeIfPresent(String.self, forKey: .unitValue) ?? ""
        nutritionWeight = try container.decodeIfPresent(String.self, forKey: .nutritionWeight) ?? ""
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        catName = try container.decodeIfPresent(String.self, forKey: .catName) ?? ""
        typeName = try container.decodeIfPresent(String.self, forKey: .typeName) ?? ""
        
        offerPrice = try container.decodeIfPresent(Double.self, forKey: .offerPrice)
        price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0
        
        // Handle date decoding from string
        if let startDateString = try container.decodeIfPresent(String.self, forKey: .startDate) {
            startDate = startDateString.stringDateToDate() ?? Date()
        } else {
            startDate = Date()
        }
        
        if let endDateString = try container.decodeIfPresent(String.self, forKey: .endDate) {
            endDate = endDateString.stringDateToDate() ?? Date()
        } else {
            endDate = Date()
        }
        
        // Handle boolean from Int
        let isFavInt = try container.decodeIfPresent(Int.self, forKey: .isFav) ?? 0
        isFav = isFavInt == 1
    }
    
    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
        return lhs.id == rhs.id
    }
}
