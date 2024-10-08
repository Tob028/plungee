//
//  WatchConnector.swift
//  plungee
//
//  Created by Tobias on 20/06/2024.
//

import Foundation
import HealthKit
import WatchConnectivity

class WatchConnector: NSObject, WCSessionDelegate, ObservableObject {
    var session: WCSession
    
    @Published var isReachable: Bool = false
    
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
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        updateConnectionStatus(session)
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        updateConnectionStatus(session)
    }
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        updateConnectionStatus(session)
    }
    
    // Handle new session
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        Task {
            do {
                print(message)
                let jsonData = try JSONSerialization.data(withJSONObject: message, options: [])
                var workout = try JSONDecoder().decode(Session.self, from: jsonData)
                
                guard let user = AuthManager.shared.user else {
                    return
                }
                
                print(workout)
                
                workout.uid = user.id
                
                try await DatabaseManager.shared.saveSessionToDB(session: workout)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateConnectionStatus(_ session: WCSession) {
        DispatchQueue.main.async {
            self.isReachable = session.isPaired && session.isWatchAppInstalled
        }
    }

}
