//
//  TabItems.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import Foundation

enum TabItems: Int, CaseIterable {
    case home = 0
    case stats = 1
    case settings = 2
}

extension TabItems {
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .stats:
            return "Stats"
        case .settings:
            return "Settings"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "house.fill"
        case .stats:
            return "chart.bar"
        case .settings:
            return "gear"
        }
    }
}
