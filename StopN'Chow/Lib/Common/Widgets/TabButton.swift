//
//  TabButton.swift
//  StopN'Chow
//
//  Created by mac on 18/02/2025.
//


import SwiftUI

struct TabButton: View {
    var tab: Tab
    @Binding var currentTab: Tab
    
    var body: some View {
        Button {
            withAnimation {
                currentTab = tab
            }
        } label: {
            VStack {
                Image(systemName: tab.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text(tab.Tabname)
                    .font(.customfont(.semibold, fontSize: 14))
                    
            }
        }
        .foregroundColor(currentTab == tab ? .primaryApp : .primaryText)
        .frame(maxWidth: .infinity)
    }
}
