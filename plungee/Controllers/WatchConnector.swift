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
    
    // MARK: Handle new session
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        /*
        let workout = Session(
            exposureType: message["type"] as? ExposureType ?? .plunge,
            startDate: message["startTime"] as? Date ?? Date.now,
            endDate: message["endTime"] as? Date ?? Date.now,
            events: message["events"] as? [HKWorkoutEvent] ?? [HKWorkoutEvent](),
            statistics: message["statistics"] as? [HKQuantityType : HKStatistics] ?? [HKQuantityType : HKStatistics]()
        )*/
        DatabaseManager.saveSessionToDB(session: message)
    }
    
    private func updateConnectionStatus(_ session: WCSession) {
        DispatchQueue.main.async {
            self.isReachable = session.isPaired && session.isWatchAppInstalled
        }
    }

}
