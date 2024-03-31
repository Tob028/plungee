//
//  ExposureType.swift
//  plungee
//
//  Created by Tobias on 15/01/2024.
//

import Foundation

enum ExposureType: String {
    case plunge = "Plunge"
    case shower = "Shower"
    case sauna = "Sauna"
}

var exposureTypes: [ExposureType] = [.plunge, .shower, .sauna]

extension ExposureType: Identifiable {
    var id: String { rawValue }
}
