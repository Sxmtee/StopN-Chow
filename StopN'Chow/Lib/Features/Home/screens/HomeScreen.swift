//
//  HomeScreen.swift
//  StopN'Chow
//
//  Created by mac on 18/02/2025.
//

import SwiftUI

struct HomeScreen: View {
    @State private var homeView = HomeViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Image("color_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                    
                    HStack {
                        Image("location")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                        
                        Texts(
                            "Enugu, Nigeria",
                            fontWeight: .customfont(.semibold, fontSize: 18),
                            color: .darkGray
                        )
                    }
                    
                    TextAreas(
                        text: $homeView.searchCtrl,
                        title: nil,
                        hintText: "Search store",
                        borderColor: .primaryText,
                        icon: "magnifyingglass"
                    )
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .padding(.vertical, 10)
                }
                .padding(.top, .topInsets)
                
                Image("banner_top")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 115)
                
                SectionTitleAll(title: "Exclusive Offer", titleAll: "See all")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 15) {
                        ForEach(0...5, id: \.self) { index in
                            ProductCell {
                                print("Done")
                            }
                        }
                    }
                }
                .padding(.bottom, 15)
                
                SectionTitleAll(title: "Groceries", titleAll: "See all")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 15) {
                        ForEach(0...5, id: \.self) { index in
                            CategoryCell {
                                print("Done")
                            }
                        }
                    }
                }
                .padding(.bottom, 15)
            }
        }
        .ignoresSafeArea()
        .padding(.horizontal, 20)
    }
}

#Preview {
    HomeScreen()
}
