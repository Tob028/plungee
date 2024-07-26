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
        // init
        self.exposureType = exposureType
        self.duration = DateInterval(start: startDate, end: endDate)
        self.events = events
        self.statistics = statistics
    }
}

struct SessionStatistics {
    var type: String
    
    var minValue: Double
    
    var maxValue: Double
    
    var avgValue: Double
    
    init(type: String, minValue: Double, maxValue: Double, avgValue: Double) {
        self.type = type
        self.minValue = minValue
        self.maxValue = maxValue
        self.avgValue = avgValue
    }
}


struct SessionEvent {
    var type: String
    
    var duration: DateInterval
    
    var metadata: [String: Any]?
    
    init(type: String, duration: DateInterval, metadata: [String: Any]?) {
        self.type = type
        self.duration = duration
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
