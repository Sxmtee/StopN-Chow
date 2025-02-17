//
//  AuthView.swift
//  StopN'Chow
//
//  Created by mac on 17/02/2025.
//

import SwiftUI

struct AuthView: View {
    @State private var isLoggedIn = UserData.isLoggedIn
    
    var body: some View {
        NavigationStack {
            Group {
                if isLoggedIn {
                    ContentView()
                        .transition(.opacity)
                } else {
                    WelcomeView()
                        .transition(.opacity)
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)) { _ in
                isLoggedIn = UserData.isLoggedIn
            }
        }
    }
}

//#Preview {
//    AuthView()
//}
