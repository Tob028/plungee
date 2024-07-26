//
//  Session.swift
//  plungee
//
//  Created by Tobias on 03/06/2024.
//

import Foundation
import HealthKit

struct Session {
    var exposureType: ExposureType
    
    var timeInterval: DateInterval
    
    var statistics: [String: Any]
    
    var events: [SessionEvents]
    
    init(
        exposureType: ExposureType,
        startDate: Date,
        endDate: Date,
        events: [SessionEvents],
        statistics: [HKQuantityType: HKStatistics]
    ) {
        // init
        self.exposureType = exposureType
        self.timeInterval = DateInterval(start: startDate, end: endDate)
        
    }
}

struct SessionStatistics {
    
}


struct SessionEvents {
    var type: String
    
    var timeInterval: DateInterval
    
    var metadata: [String: Any]?
    
    init(type: HKWorkoutEventType, timeInterval: DateInterval, metadata: [String: Any]?) {
        self.type = type.stringValue
        self.timeInterval = timeInterval
        self.metadata = metadata
    }
}

extension HKWorkoutEventType {
    var stringValue: String {
        switch self {
        case .pause:
            return "pause"
        case .resume:
            return "resume"
        case .lap:
            return "lap"
        case .marker:
            return "marker"
        case .motionPaused:
            return "motionPaused"
        case .motionResumed:
            return "motionResumed"
        case .segment:
            return "segment"
        case .pauseOrResumeRequest:
            return "pauseOrResumeRequest"
        @unknown default:
            fatalError("Unknown HKWorkoutEventType")
        }
    }
    
    init?(stringValue: String) {
        switch stringValue {
        case "pause":
            self = .pause
        case "resume":
            self = .resume
        case "lap":
            self = .lap
        case "marker":
            self = .marker
        case "motionPaused":
            self = .motionPaused
        case "motionResumed":
            self = .motionResumed
        case "segment":
            self = .segment
        case "pauseOrResumeRequest":
            self = .pauseOrResumeRequest
        default:
            return nil
        }
    }
}
