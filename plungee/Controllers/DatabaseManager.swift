//
//  DatabaseManager.swift
//  plungee
//
//  Created by Tobias on 06/07/2024.
//

import Foundation
import FirebaseFirestore

class DatabaseManager: ObservableObject {
    static let shared = DatabaseManager()
    
    let db = Firestore.firestore()
    
    func saveSessionToDB(session: Session) async throws {
        do {
            try db.collection("sessions").document(session.id.uuidString).setData(from: session)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func fetchSessionData() async throws -> [Session] {
        do {
            let querySnapshot = try await db.collection("sessions").getDocuments()
            let sessions: [Session] = try querySnapshot.documents.compactMap { document in
                try document.data(as: Session.self)
            }
            print(sessions)
            return sessions
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
