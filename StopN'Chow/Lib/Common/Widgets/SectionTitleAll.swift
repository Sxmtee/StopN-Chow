//
//  SectionTitleAll.swift
//  StopN'Chow
//
//  Created by mac on 20/02/2025.
//

import SwiftUI

struct SectionTitleAll: View {
    var title: String
    var titleAll: String
    var onTap: (()->())?
    
    var body: some View {
        HStack {
            Text(title)
                .font(.customfont(.semibold, fontSize: 24))
                .foregroundStyle(Color.primaryText)
            
            Spacer()
            
            Text(titleAll)
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundStyle(Color.primaryApp)
                .onTapGesture {
                    onTap?()
                }
        }
        .frame(height: 40)
    }
}

//#Preview {
//    SectionTitleAll()
//}
