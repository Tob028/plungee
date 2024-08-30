//
//  ExposureType.swift
//  plungee
//
//  Created by Tobias on 15/01/2024.
//

import Foundation

enum ExposureType: String, Hashable, Codable {
    case plunge = "Plunge"
    case shower = "Shower"
    case sauna = "Sauna"
    
    var icon: String {
        switch self {
        case .plunge:
            return "🧊" // ❄️
        case .shower:
            return "🚿"
        case .sauna:
            return "🔥" // 😶‍🌫️
        }
    }
}

var exposureTypes: [ExposureType] = [.plunge, .shower, .sauna]



extension ExposureType: Identifiable {
    var id: String { rawValue }
}
