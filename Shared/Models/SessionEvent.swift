//
//  SessionEvent.swift
//  plungee
//
//  Created by Tobias on 12/08/2024.
//

import Foundation
import HealthKit

struct SessionEvent: Codable, Identifiable {
    var id: UUID = UUID()
    
    var type: String
    
    var startDate: Date
    
    var endDate: Date
    
    //var metadata: [String: Any]?
    
    init(type: String, startDate: Date, endDate: Date, metadata: [String: Any]?) {
        self.type = type
        self.startDate = startDate
        self.endDate = endDate
        //self.metadata = metadata
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
