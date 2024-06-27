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
    
    var events: [HKWorkoutEvent]
    
    var configuration: HKWorkoutConfiguration
    
    init(
        exposureType: ExposureType,
        startDate: Date,
        endDate: Date,
        configutation: HKWorkoutConfiguration,
        events: [HKWorkoutEvent],
        statistics: [HKQuantityType: HKStatistics]
    ) {
        self.exposureType = exposureType
        timeInterval = DateInterval(start: startDate, end: endDate)
        self.configuration = configutation
        self.events = events
        self.statistics = statistics
    }
}
