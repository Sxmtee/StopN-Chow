//
//  StopPreferences.swift
//  StopN'Chow
//
//  Created by mac on 17/02/2025.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

class UserData {
    @UserDefault("username", defaultValue: "")
    static var username: String
    
    @UserDefault("email", defaultValue: "")
    static var email: String
    
    @UserDefault("password", defaultValue: "")
    static var password: String
    
    @UserDefault("isLoggedIn", defaultValue: false)
    static var isLoggedIn: Bool
    
    static func clearAll() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
    }
}
