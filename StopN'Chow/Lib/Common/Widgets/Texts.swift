//
//  Texts.swift
//  StopN'Chow
//
//  Created by mac on 06/02/2025.
//

import SwiftUI

struct Texts: View {
    let text: String
    let fontSize: CGFloat
    let fontWeight: Font
    let color: Color
    let alignment: TextAlignment

    init(
        _ text: String,
        fontSize: CGFloat = 18,
        fontWeight: Font = .customfont(.semibold, fontSize: 18),
        color: Color = .white,
        alignment: TextAlignment = .center
    ) {
        self.text = text
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.color = color
        self.alignment = alignment
    }

    var body: some View {
        Text(text)
            .font(fontWeight)
            .foregroundColor(color)
            .multilineTextAlignment(alignment)
    }
}
