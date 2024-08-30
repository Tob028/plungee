//
//  DatabaseService.swift
//  plungee
//
//  Created by Tobias on 30/08/2024.
//

import Foundation

protocol DatabaseService: ObservableObject {
    func saveSessionToDB(session: Session) -> Void
    func fetchSessionData()
}
