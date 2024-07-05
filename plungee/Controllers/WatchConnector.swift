//
//  WatchConnector.swift
//  plungee
//
//  Created by Tobias on 20/06/2024.
//

import Foundation
import WatchConnectivity

class WatchConnector: NSObject, WCSessionDelegate, ObservableObject {
    var session: WCSession
    
    @Published var isReachable: Bool = false
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
        print("WC init")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        if (error != nil) {
            print(error?.localizedDescription ?? "")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        updateConnectionStatus(session)
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        updateConnectionStatus(session)
    }
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        updateConnectionStatus(session)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print(message)
    }
    
    private func updateConnectionStatus(_ session: WCSession) {
        DispatchQueue.main.async {
            self.isReachable = session.isPaired && session.isWatchAppInstalled
        }
    }

}
