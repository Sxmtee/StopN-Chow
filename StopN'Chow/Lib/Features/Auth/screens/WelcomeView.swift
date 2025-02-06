//
//  WelcomeView.swift
//  StopN'Chow
//
//  Created by mac on 06/02/2025.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("welcom_bg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .screenWidth, height: .screenHeight)
                
                VStack {
                    Spacer()
                    
                    Image("app_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .padding(.bottom, 8)
                    
                    Text( "Welcome\nto our store")
                        .font(.customfont(.semibold, fontSize: 48))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text( "Get your groceries in as fast as one hour")
                        .font(.customfont(.medium, fontSize: 16))
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 30)
                    
                    NavigationLink {
                        SignIn()
                    } label: {
                        RoundButton(
                            action: {},
                            text: "Get Started"
                        )
                    }
                    
                    Spacer()
                        .frame(height: 80)
                    
                }
                .padding(.horizontal, 20)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    WelcomeView()
}
