//
//  RoundButton.swift
//  StopN'Chow
//
//  Created by mac on 06/02/2025.
//


import SwiftUI

struct RoundButton: View {
    let action: () -> Void
    let height: CGFloat
    let width: CGFloat
    let backgroundColor: Color
    let textColor: Color
    let borderColor: Color
    let text: String
    let font: Font

    init(
        action: @escaping () -> Void,
        height: CGFloat = 60,
        width: CGFloat = .infinity, //prev->200
        backgroundColor: Color = Color.primaryApp,
        textColor: Color = Color.white,
        borderColor: Color = Color.clear,
        text: String,
        font: Font = .customfont(.semibold, fontSize: 18)
    ) {
        self.action = action
        self.height = height
        self.width = width
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.borderColor = borderColor
        self.text = text
        self.font = font
    }

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(font)
                .foregroundColor(textColor)
                .multilineTextAlignment(.center)
        }
        .frame(minWidth: 0, maxWidth: width, minHeight: height, maxHeight: height)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(borderColor, lineWidth: 1)
        )
    }
}
