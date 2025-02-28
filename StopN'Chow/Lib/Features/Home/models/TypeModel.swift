//
//  TypeModel.swift
//  StopN'Chow
//
//  Created by mac on 27/02/2025.
//

import SwiftUI

struct TypeModel: Codable, Identifiable, Equatable {
    var id: Int
    var name: String
    var image: String
    var color: Color
    
    private enum CodingKeys: String, CodingKey {
        case id = "type_id"
        case name = "type_name"
        case image
        case color
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        
        if let colorString = try container.decodeIfPresent(String.self, forKey: .color) {
            color = Color(hex: colorString)
        } else {
            color = Color.primaryApp
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(image, forKey: .image)
        
        // Assuming Color has a method to convert to hex string
        let colorString = color.toHexString()
        try container.encode(colorString, forKey: .color)
    }
    
    static func == (lhs: TypeModel, rhs: TypeModel) -> Bool {
        return lhs.id == rhs.id
    }
}
