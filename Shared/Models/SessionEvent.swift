//
//  SessionEvent.swift
//  plungee
//
//  Created by Tobias on 12/08/2024.
//

import Foundation
import HealthKit

struct SessionEvent {
    var type: String
    
    var duration: DateInterval
    
    var metadata: [String: Any]?
    
    init(type: String, duration: DateInterval, metadata: [String: Any]?) {
        self.type = type
        self.duration = duration
        self.metadata = metadata
    }
    
    func serialize() -> [String: Any] {
        var dict: [String: Any] = [:]
        
        dict["type"] = type
        dict["duration"] = [
            "startDate": duration.start.timeIntervalSince1970,
            "endDate": duration.end.timeIntervalSince1970
        ]
        dict["metadata"] = metadata
        
        return dict
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
