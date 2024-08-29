//
//  Session.swift
//  plungee
//
//  Created by Tobias on 03/06/2024.
//

import Foundation

struct Session: Codable, Identifiable {
    var id: UUID = UUID()
    
    var exposureType: ExposureType
    
    //var duration: DateInterval
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
}
