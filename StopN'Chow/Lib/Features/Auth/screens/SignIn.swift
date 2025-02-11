//
//  SignIn.swift
//  StopN'Chow
//
//  Created by mac on 06/02/2025.
//

import SwiftUI
import CountryPicker

struct SignIn: View {
    @State private var mobileTextCtrl = ""
    @State private var isShowing = false
    @State private var countryObj: Country?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bottom_bg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .screenWidth, height: .screenHeight)
                
                VStack {
                    Image("sign_in_top")
                        .resizable()
                        .scaledToFill()
                        .frame(width: .screenWidth, height: .screenWidth)
                    
                    Spacer()
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Texts(
                            "Get your groceries\nwith nectar",
                            fontWeight: .customfont(.semibold, fontSize: 26),
                            color: Color.primaryText,
                            alignment: .leading
                        )
                        .padding(.bottom, 25)
                        
                        HStack {
                            Button {
                                isShowing = true
                            } label: {
                                if let countryObj = countryObj {
                                    Texts(
                                        "\(countryObj.isoCode.getFlag())",
                                        fontWeight: .customfont(.medium, fontSize: 35)
                                    )
                                    
                                    Texts(
                                        "+\(countryObj.phoneCode)",
                                        fontWeight: .customfont(.medium, fontSize: 18),
                                        color: Color.primaryText
                                    )
                                }
                            }
                            
                            TextField("Enter mobile number", text: $mobileTextCtrl)
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        
                        Divider()
                            .padding(.bottom, 25)
                        
                        Texts(
                            "or connect with social media",
                            fontWeight: .customfont(.semibold, fontSize: 14),
                            color: Color.textTitle,
                            alignment: .center
                        )
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 25)
                        
                        RoundButton(
                            backgroundColor: Color(hex: "5383EC"),
                            text: "Continue with Google"
                        )
                        .padding(.bottom, 8)
                        
                        RoundButton(
                            backgroundColor: Color(hex: "4A66AC"),
                            text: "Continue with Facebook"
                        )
                    }
                    .padding(.horizontal, 20)
                    .frame(width: .screenWidth, alignment: .leading)
                    .padding(.top, .topInsets +  .screenWidth * 0.6)
                }
            }
            .onAppear {
                self.countryObj = Country(phoneCode: "234", isoCode: "NG")
            }
            .sheet(
                isPresented: $isShowing,
                content: {
                    CountryPickerUI(country: $countryObj)
                }
            )
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SignIn()
}
