//
//  CategoryCell.swift
//  StopN'Chow
//
//  Created by mac on 26/02/2025.
//

import SwiftUI

struct CategoryCell: View {
    var addToCart: (()->())?
    
    var body: some View {
        HStack {
            Image("pulses")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 80)
            
            Text("Pulses")
                .font(.customfont(.bold, fontSize: 16))
                .foregroundStyle(Color.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(15)
        .frame(width: 250, height: 100)
        .background(Color.yellow.opacity(0.3))
        .clipShape (RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    CategoryCell()
}
