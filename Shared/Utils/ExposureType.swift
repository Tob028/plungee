//
//  ExposureType.swift
//  plungee
//
//  Created by Tobias on 15/01/2024.
//

import Foundation

enum ExposureType: String, Hashable {
    case plunge = "Plunge"
    case shower = "Shower"
    case sauna = "Sauna"
}

struct TrackingTypes {
    var type: ExposureType
    
}

var exposureTypes: [ExposureType] = [.plunge, .shower, .sauna]

extension ExposureType: Identifiable {
    var id: String { rawValue }
}
