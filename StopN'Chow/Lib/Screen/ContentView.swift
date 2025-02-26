//
//  ContentView.swift
//  StopN'Chow
//
//  Created by mac on 05/02/2025.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case Shop = "store_tab"
    case Explore = "explore_tab"
    case Cart = "cart_tab"
    case Favourite = "fav_tab"
    case Account = "account_tab"
    
    var Tabname: String {
        switch self {
        case .Shop:
            return "Shop"
        case .Explore:
            return "Explore"
        case .Cart:
            return "Cart"
        case .Favourite:
            return "Favourite"
        case .Account:
            return "Account"
        }
    }
    
    var iconName: String {
        switch self {
        case .Shop: 
            return "house.fill"
        case .Explore: 
            return "magnifyingglass"
        case .Cart: 
            return "cart.fill"
        case .Favourite: 
            return "heart.fill"
        case .Account: 
            return "person.fill"
        }
    }
}

struct ContentView: View {
    @State private var currentTab: Tab = .Shop
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentTab) {
                HomeScreen()
                    .tag(Tab.Shop)
                
                Text("Search View")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .tag(Tab.Explore)
                
                Text("Notifications View")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .tag(Tab.Cart)
                
                Text("Cart View")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .tag(Tab.Favourite)
                
                Text("Profile View")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .tag(Tab.Account)
            }
            
            // Custom Tab Bar
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    TabButton(
                        tab: tab,
                        currentTab: $currentTab
                    )
                }
            }
            .padding(.top, 10)
            .padding(.bottom, .bottomInsets)
            .padding(.horizontal, 10)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(
                color: Color.black.opacity(0.15),
                radius: 3,
                x: 0,
                y: -2
            )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ContentView()
}
