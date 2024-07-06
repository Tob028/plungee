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
    
    func sendSessionToIOS(workout: HKWorkout?) {
        if (session.isReachable) {
            let data: [String: Any] = ["duration": workout?.duration ?? 0]
            session.sendMessage(data, replyHandler: nil)
        } else {
            print("session is not reachable")
        }
    }
}
