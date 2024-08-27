//
//  DatabaseManager.swift
//  plungee
//
//  Created by Tobias on 06/07/2024.
//

import Foundation
import FirebaseFirestore

class DatabaseManager {
    static let db = Firestore.firestore()
    
    static func saveSessionToDB(session: [String: Any]) {
        db.collection("sessions").addDocument(data: session) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        print(session)
        return
    }
}
