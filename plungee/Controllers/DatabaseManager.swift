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
    
    func saveSessionToDB(session: Session) {
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
            print(error.localizedDescription)
        }
    }
    
    func fetchSessionData(completion: @escaping ([Session]) -> Void) {
        db.collection("sessions").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching sessions: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                completion([])
                return
            }
            
            let sessions: [Session] = documents.compactMap { document in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                    return try JSONDecoder().decode(Session.self, from: jsonData)
                } catch {
                    print("Error decoding session: \(error.localizedDescription)")
                    return nil
                }
            }
            
            completion(sessions)
        }
    }
}
