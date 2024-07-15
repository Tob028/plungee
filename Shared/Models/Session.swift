//
//  Session.swift
//  plungee
//
//  Created by Tobias on 03/06/2024.
//

import Foundation
import HealthKit

class Session {
    var exposureType: ExposureType
    
    var timeInterval: DateInterval
    
    var statistics: [HKQuantityType: HKStatistics]
    
    var events: [[String: Any]]
    
    //var configuration: HKWorkoutConfiguration
    
    init(
        exposureType: ExposureType,
        startDate: Date?,
        endDate: Date?,
        //configutation: HKWorkoutConfiguration,
        events: [HKWorkoutEvent],
        statistics: [HKQuantityType: HKStatistics]
    ) {
        self.exposureType = exposureType
        timeInterval = DateInterval(start: startDate ?? Date.now, end: endDate ?? Date.now)
        //self.configuration = configutation
        self.events = events.map { event in
            [
                "type": event.type.rawValue,
                "startDate": event.dateInterval.start,
                "endDate": event.dateInterval.end
            ]
        }

        self.statistics = statistics
    }
    
    func serializeStatistics() -> [String: Any] {
        var serializedStats = [String: Any]()
        
        for (quantityType, statistics) in statistics {
            let unit = HKUnit.count().unitDivided(by: .minute()) // Adjust this to the unit you want
            let avgValue = statistics.averageQuantity()?.doubleValue(for: unit)
            let maxValue = statistics.maximumQuantity()?.doubleValue(for: unit)
            let minValue = statistics.minimumQuantity()?.doubleValue(for: unit)
            
            serializedStats[quantityType.identifier] = [
                "average": avgValue as Any,
                "maximum": maxValue as Any,
                "minimum": minValue as Any
            ]
        }
        
        return serializedStats
    }
    
    func serialize() -> [String: Any] {
        return [
            "exposureType": exposureType.rawValue,
            "startDate": timeInterval.start,
            "endDate": timeInterval.end,
            "events": events,
            "statistics": serializeStatistics()
        ]
    }
}


