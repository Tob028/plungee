//
//  ContentView.swift
//  plungee
//
//  Created by Tobias on 15/01/2024.
//

import SwiftUI

struct MainView: View {
    @State var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tag(0)
                        .toolbar(.hidden, for: .tabBar)
                    
                    StatsView()
                        .tag(1)
                        .toolbar(.hidden, for: .tabBar)
                    
                    SettingsView()
                        .tag(2)
                        .toolbar(.hidden, for: .tabBar)
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
            .background(.black.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 35, style: .circular))
            .padding(.horizontal, 26)
        }
        .preferredColorScheme(.light)
    }
}

extension MainView {
    func CustomTabItem(iconName: String, title: String, isActive: Bool) -> some View {
        HStack(spacing: 10) {
            Spacer()
            Image(systemName: iconName)
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
            
            if (isActive) {
                Text(title)
                    .font(.system(size: 17, weight: .bold, design: .default))
            }
            
            Spacer()
        }
        .frame(width: isActive ? .infinity : 60, height: 60)
        .foregroundStyle(.white)
        .background(isActive ? .black.opacity(0.6) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .circular))
    }
    
}


#Preview {
    MainView()
}
