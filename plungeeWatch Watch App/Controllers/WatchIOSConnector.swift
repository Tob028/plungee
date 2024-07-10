//
//  WatchIOSConnector.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 02/07/2024.
//

import Foundation
import HealthKit
import WatchConnectivity

class WatchIOSConnector: NSObject, WCSessionDelegate, ObservableObject {
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        if (error != nil) {
            print(error?.localizedDescription ?? "")
        }
    }
    
    func sendSessionToIOS(workout: Session) {
        if (session.isReachable) {
            let data: [String: Any] = [
                "type": workout.exposureType as Any,
                "startTime": workout.timeInterval.start as Any,
                "endTime": workout.timeInterval.end as Any,
                "statistics": workout.statistics as Any,
                "events": workout.events as Any
            ]
            print(workout.events)
            print(workout.statistics)
            session.sendMessage(data, replyHandler: nil) { error in
                print(error.localizedDescription)
            }
        } else {
            print("session is not reachable")
        }
    }
}
