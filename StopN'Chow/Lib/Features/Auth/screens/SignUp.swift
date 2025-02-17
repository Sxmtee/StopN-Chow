//
//  SignUp.swift
//  StopN'Chow
//
//  Created by mac on 14/02/2025.
//

import SwiftUI

struct SignUp: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel = AuthViewModel()
    
    var body: some View {
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
                    "Sign Up",
                    fontWeight: .customfont(.semibold, fontSize: 26),
                    color: .primaryText
                )
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 5)
                
                Texts(
                    "Enter your credentials",
                    fontWeight: .customfont(.semibold, fontSize: 16),
                    color: .secondaryText
                )
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, .screenWidth * 0.1)
                
                TextAreas(
                    text: $viewModel.name,
                    title: "Name",
                    hintText: "enter your full name",
                    borderColor: .primaryApp,
                    icon: "person"
                )
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding(.bottom, .screenWidth * 0.07)
                
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
                
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Text("Already have an account?")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundStyle(Color.primaryText)
                        
                        Text("Login")
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
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }

                    Spacer()
                }

                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
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

#Preview {
    SignUp()
}
