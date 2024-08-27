//
//  WatchConnectorIOS.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 26/08/2024.
//

import Foundation
import WatchConnectivity

class WatchConnectorIOS: NSObject, ObservableObject, WCSessionDelegate {
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

    func sendSession(workout: Session) {
        if (session.isReachable) {
            let data = workout.serialize()
            session.sendMessage(data, replyHandler: nil)
        } else {
            // TODO: Handle iphone unreachable
            print("session is not reachable")
        }
    }
}
