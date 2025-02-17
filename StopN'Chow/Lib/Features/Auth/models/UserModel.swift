//
//  UserModel.swift
//  StopN'Chow
//
//  Created by mac on 11/02/2025.
//


import SwiftUI

struct UserModel: Codable, Identifiable, Equatable {
    let id: Int
    let username: String
    let name: String
    let email: String
    let mobile: String
    let mobileCode: String
    let authToken: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case username
        case name
        case email
        case mobile
        case mobileCode = "mobile_code"
        case authToken = "auth_token"
    }
    
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
    }
}
