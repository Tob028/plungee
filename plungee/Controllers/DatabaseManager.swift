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
    let authManager = AuthManager.shared
    
    func saveSessionToDB(session: Session) async throws {
        try db.collection("sessions").document(session.id.uuidString).setData(from: session)
    }
    
    @MainActor
    func getSessions() async throws -> [Session] {
        guard let user = authManager.user else {
            throw NSError(domain: "SessionFetch", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user signed in."])
        }
        
        
        let uid = user.id
        
        let querySnapshot = try await db.collection("sessions")
            .whereField("uid", isEqualTo: uid)
            .order(by: "startDate", descending: true)
            .getDocuments()
        
        let sessions: [Session] = try querySnapshot.documents.compactMap { document in
            try document.data(as: Session.self)
        }
        
        return sessions
    }
    
    
    func saveNewUser(user: User) async throws {
        try db.collection("users").document(user.id).setData(from: user)
    }
    
    func getUserDoc(uid: String) async throws -> DocumentSnapshot {
        let doc = try await db.collection("users").document(uid).getDocument()
        
        return doc
    }
    
    func getUser(uid: String) async throws -> User {
        let doc = try await getUserDoc(uid: uid)
        
        let user: User = try doc.data(as: User.self)
        
        return user
    }
}
