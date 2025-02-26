//
//  ProductCell.swift
//  StopN'Chow
//
//  Created by mac on 20/02/2025.
//

import SwiftUI

struct ProductCell: View {
    var addToCart: (()->())?
    
    var body: some View {
        VStack {
            Image("banana")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 80)
            
            Spacer()
            
            Text("Banana")
                .font(.customfont(.bold, fontSize: 16))
                .foregroundStyle(Color.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("7pcs per price")
                .font(.customfont(.medium, fontSize: 14))
                .foregroundStyle(Color.secondaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            HStack {
                Text("$2.99")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundStyle(Color.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Button {
                    addToCart?()
                } label: {
                    Image("addd")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                }
                .frame(width: 40, height: 40)
                .background(Color.primaryApp)
                .clipShape(
                    RoundedRectangle(cornerRadius: 15)
                )
            }
        }
        .padding(10)
        .frame(width: 180, height: 230)
        .overlay (
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.primaryText, lineWidth: 1)
        )
    }
}

#Preview {
    ProductCell()
}
