//
//  TextAreas.swift
//  StopN'Chow
//
//  Created by mac on 10/02/2025.
//

import SwiftUI

struct TextAreas: View {
    @Binding var text: String
    @State private var isPasswordVisible = false
    let title: String?
    let titleFont: Font = .customfont(.semibold, fontSize: 16)
    let titleColor: Color = .textTitle
    let hintText: String
    var borderColor: Color = .blue
    let icon: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: title != nil ? 3.0 : 0) {
            if let title = title {
                Text(title)
                    .font(titleFont)
                    .foregroundStyle(titleColor)
            }
            
            HStack {
                // Prefix Icon
                Image(systemName: icon)
                    .foregroundColor(.gray)
                    .frame(width: 20, height: 20)
                    .padding(.leading, 15)
                
                // Text Input
                if isSecureField {
                    Group {
                        if isPasswordVisible {
                            TextField(hintText, text: $text)
                        } else {
                            SecureField(hintText, text: $text)
                        }
                    }
                    .textFieldStyle(.plain)
                    
                    // Password Toggle Button
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(.gray)
                            .frame(width: 20, height: 20)
                    }
                    .padding(.trailing, 15)
                } else {
                    TextField(hintText, text: $text)
                        .textFieldStyle(.plain)
                }
            }
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(borderColor, lineWidth: 1)
            )
        }
    }
}
