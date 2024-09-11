//
//  Session.swift
//  plungee
//
//  Created by Tobias on 03/06/2024.
//

import Foundation

struct Session: Codable, Identifiable {
    var id: UUID = UUID()
    
    var uid: String?
    
    var exposureType: ExposureType
    
    var startDate: Date
    
    var endDate: Date
    
    var statistics: [SessionStatistics]
    
    var events: [SessionEvent]
    
    init(
        exposureType: ExposureType,
        startDate: Date,
        endDate: Date,
        events: [SessionEvent],
        statistics: [SessionStatistics]
    ) {
        self.exposureType = exposureType
        self.startDate = startDate
        self.endDate = endDate
        self.events = events
        self.statistics = statistics
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case uid
        case exposureType
        case startDate
        case endDate
        case statistics
        case events
    }
}
