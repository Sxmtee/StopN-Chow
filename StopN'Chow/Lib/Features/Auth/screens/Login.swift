//
//  Login.swift
//  StopN'Chow
//
//  Created by mac on 07/02/2025.
//

import SwiftUI

struct Login: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bottom_bg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .screenWidth, height: .screenHeight)
                
                VStack {
                    Image("color_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .padding(.bottom, .screenWidth * 0.12)
                    
                    Texts(
                        "Login",
                        fontWeight: .customfont(.semibold, fontSize: 26),
                        color: .primaryText
                    )
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 5)
                    
                    Texts(
                        "Enter your email and password",
                        fontWeight: .customfont(.semibold, fontSize: 16),
                        color: .secondaryText
                    )
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, .screenWidth * 0.1)
                    
                    TextAreas(
                        text: $viewModel.email,
                        title: "Email",
                        hintText: "enter your email address",
                        borderColor: .primaryApp,
                        icon: "mail"
                    )
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .padding(.bottom, .screenWidth * 0.07)
                    
                    TextAreas(
                        text: $viewModel.password,
                        title: "Password",
                        hintText: "enter your password",
                        borderColor: .primaryApp,
                        icon: "lock.fill",
                        isSecureField: true
                    )
                    .keyboardType(.default)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .padding(.bottom, .screenWidth * 0.02)
                    
                    Button {
                        // code to come
                    } label: {
                        Text("Forgot password ?")
                            .font(.customfont(.medium, fontSize: 15))
                            .foregroundStyle(Color.primaryText)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.bottom, .screenWidth * 0.05)
                    
                    RoundButton(
                        action: {
                            Task {
                                await viewModel.login()
                            }
                        },
                        text: "Login"
                    )
                    .padding(.bottom, .screenWidth * 0.03)
                    
                    NavigationLink {
                        SignUp()
                    } label: {
                        HStack {
                            Text("Do not have an account?")
                                .font(.customfont(.semibold, fontSize: 16))
                                .foregroundStyle(Color.primaryText)
                            
                            Text("Sign up")
                                .font(.customfont(.semibold, fontSize: 16))
                                .foregroundStyle(Color.primaryApp)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }

                    Spacer()
                }
                .padding(.top, .topInsets + 64)
                .padding(.horizontal, 20)
                .padding(.bottom, .bottomInsets)
            }
            .snackbar(
                isShowing: $viewModel.showErrorSnackbar,
                message: viewModel.error ?? ""
            )
            .snackbar(
                isShowing: $viewModel.showSuccessSnackbar,
                message: viewModel.successMessage ?? "",
                isSuccess: true
            )
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    Login()
}
