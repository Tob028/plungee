//
//  Session.swift
//  plungee
//
//  Created by Tobias on 03/06/2024.
//

import Foundation

struct Session {
    var exposureType: ExposureType
    
    var duration: DateInterval
    
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
        self.duration = DateInterval(start: startDate, end: endDate)
        self.events = events
        self.statistics = statistics
    }
    
    func serialize() -> [String: Any] {
        var dict: [String: Any] = [:]
        
        dict["exposureType"] = exposureType.rawValue
        dict["duration"] = [
            "startDate": duration.start.timeIntervalSince1970,
            "endDate": duration.end.timeIntervalSince1970
        ]
        
        dict["statistics"] = statistics.map { $0.serialize() }
        dict["events"] = events.map { $0.serialize() }
        
        return dict
    }
}
