//
//  LoginViewModel.swift
//  StopN'Chow
//
//  Created by mac on 11/02/2025.
//

import SwiftUI

@Observable
class LoginViewModel {
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
    var isEmailValid = false
    var isPasswordValid = false
    
    init() {
        validateEmail()
        validatePassword()
    }
    
//    private func validateName() {
//        isNameValid = name.count >= 3
//    }
    
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
            let response: APIResponse<LoginPayload> = try await ServiceCall.postWithResponse(
                parameters: [
                    "email": email,
                    "password": password
                ],
                path: GlobalEndpoints.Login
            )
            
            // Now you can handle the response, for example:
            if response.isSuccess {
                // Login successful
//                if let userData = response.payload {
//
//                    // e.g., save userToken, userId, etc.
//                }
                
                successMessage = response.message
            } else {
                error = response.message
            }
        } catch {
            self.error = "\(error.localizedDescription)"
        }
    }
}
