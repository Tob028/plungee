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
    
    static func saveSessionToDB(session: Session) {
        do {
            let data = try JSONEncoder().encode(session)
            
            if let sessionDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                db.collection("sessions").addDocument(data: sessionDictionary) { error in
                    if let error = error {
                        print("Error saving session to Firestore: \(error.localizedDescription)")
                    }
                }
            }
        } catch {
            print("Failed to encode session: \(error.localizedDescription)")
        }
    }
}
