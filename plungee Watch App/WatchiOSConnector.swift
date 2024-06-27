//
//  WatchiOSConnector.swift
//  plungee Watch App
//
//  Created by Tobias on 20/06/2024.
//

import Foundation
import WatchConnectivity

class WatchiOSConnector: NSObject, WCSessionDelegate {
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
    }
    
    func sendSessionToiOS(session: Session) {
        //send
        print("sendto ios")
    }
}
