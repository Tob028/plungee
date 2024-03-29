//
//  TabbedView.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import SwiftUI

struct TabbedView: View {
    @State var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)
                
                StatsView()
                    .tag(1)
                
                SettingsView()
                    .tag(2)
            }
        }
        
        ZStack{
            HStack{
                ForEach((TabItems.allCases), id: \.self){ item in
                    Button{
                        selectedTab = item.rawValue
                    } label: {
                        CustomTabItem(iconName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                    }
                }
            }
            .padding(6)
        }
        .frame(height: 70)
        .background(.purple.opacity(0.2))
        .cornerRadius(35)
        .padding(.horizontal, 26)

    }
}

extension TabbedView {
    func CustomTabItem(iconName: String, title: String, isActive: Bool) -> some View{
            HStack(spacing: 10){
                Spacer()
                Image(systemName: iconName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(isActive ? .black : .gray)
                    .frame(width: 20, height: 20)
                
                if (isActive) {
                    Text(title)
                        .font(.system(size: 14))
                        .foregroundColor(isActive ? .black : .gray)
                }
                
                Spacer()
            }
            .frame(width: isActive ? .infinity : 60, height: 60)
            .background(isActive ? .purple.opacity(0.4) : .clear)
            .cornerRadius(30)
        }

}

#Preview {
    TabbedView()
}
