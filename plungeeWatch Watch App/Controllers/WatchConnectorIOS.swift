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
        if error != nil {
            print(error?.localizedDescription ?? "")
        }
    }

    func sendSession(workout: Session) {
        if session.isReachable {
            do {
                let data = try JSONEncoder().encode(workout)
                
                if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    session.sendMessage(dictionary, replyHandler: nil)
                    print(dictionary)
                }
            } catch {
                print("Failed to encode session: \(error.localizedDescription)")
            }
        } else {
            // Handle iPhone unreachable
            print("session is not reachable")
        }
    }
}
