//
//  AuthViewModel.swift
//  StopN'Chow
//
//  Created by mac on 11/02/2025.
//

import SwiftyNetworking
import SwiftUI

@Observable
class AuthViewModel {
    var name = "" {
        didSet { validateName() }
    }
    var email = "" {
        didSet { validateEmail() }
    }
    var password = "" {
        didSet { validatePassword() }
    }
    
    var showErrorSnackbar = false
    var showSuccessSnackbar = false
    var isLoading = false
    
    var error: String? {
        didSet {
            if error != nil {
                showErrorSnackbar = true
            }
        }
    }
    var successMessage: String? {
        didSet {
            if successMessage != nil {
                showSuccessSnackbar = true
                showErrorSnackbar = false
            }
        }
    }
    
    // Validation states
    var isNameValid = false
    var isEmailValid = false
    var isPasswordValid = false
    
    init() {
        validateName()
        validateEmail()
        validatePassword()
    }
    
    private func validateName() {
        isNameValid = name.count >= 3
    }
    
    private func validateEmail() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        isEmailValid = emailPredicate.evaluate(with: email)
    }
    
    private func validatePassword() {
        isPasswordValid = password.count >= 8
    }
    
    func login() async {
        guard isEmailValid else {
            error = "Please enter a valid email address"
            return
        }
        
        guard isPasswordValid else {
            error = "Password must be at least 8 characters long"
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let loginParameters = [
                "email": email,
                "password": password
            ]
            
            // Convert the parameters to form-url-encoded data
            let bodyString = loginParameters.map { key, value in
                let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? key
                let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
                return "\(encodedKey)=\(encodedValue)"
            }.joined(separator: "&")
            
            // Convert the string to Data
            let bodyData = bodyString.data(using: .utf8)
            
            let request = try SwiftyNetworkingRequest(
                url: URL(string: GlobalEndpoints.Login),
                method: .post,
                headers: ["Content-Type":"application/x-www-form-urlencoded"],
                body: bodyData,
                cachePolicy: .reloadIgnoringCacheData,
                timeout: 60
            )
            
            let response: APIResponse<UserModel> = try await ServiceCall.performRequest(request)
            
            // Now you can handle the response, for example:
            if response.isSuccess {
                // Login successful
                if let userData = response.payload {
                    UserData.email = userData.email
                    UserData.isLoggedIn = true
                }
                successMessage = response.message
            } else {
                UserData.isLoggedIn = false
                error = response.message
            }
        } catch {
            UserData.isLoggedIn = false
            self.error = "\(error.localizedDescription)"
        }
    }
    
    func signUp() async {
        guard isNameValid else {
            error = "Please enter a valid name longer than 3 characters"
            return
        }
        
        guard isEmailValid else {
            error = "Please enter a valid email address"
            return
        }
        
        guard isPasswordValid else {
            error = "Password must be at least 8 characters long"
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let loginParameters = [
                "name": name,
                "email": email,
                "password": password
            ]
            
            // Convert the parameters to form-url-encoded data
            let bodyString = loginParameters.map { key, value in
                let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? key
                let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
                return "\(encodedKey)=\(encodedValue)"
            }.joined(separator: "&")
            
            // Convert the string to Data
            let bodyData = bodyString.data(using: .utf8)
            
            let request = try SwiftyNetworkingRequest(
                url: URL(string: GlobalEndpoints.SignUp),
                method: .post,
                headers: ["Content-Type":"application/x-www-form-urlencoded"],
                body: bodyData,
                cachePolicy: .reloadIgnoringCacheData,
                timeout: 60
            )
            
            let response: APIResponse<UserModel> = try await ServiceCall.performRequest(request)
            
            // Now you can handle the response, for example:
            if response.isSuccess {
                // Login successful
                if let userData = response.payload {
                    UserData.email = userData.email
                    UserData.username = userData.username
                    UserData.isLoggedIn = true
                }
                
                successMessage = response.message
            } else {
                UserData.isLoggedIn = false
                error = response.message
            }
        } catch {
            UserData.isLoggedIn = false
            self.error = "\(error.localizedDescription)"
        }
    }
}
