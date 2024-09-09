//
//  User.swift
//  plungee
//
//  Created by Tobiáš Bednář on 06.09.2024.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    
    var email: String
    
    var displayName: String
    
    var createdAt: Date
    
    init(id: String, email: String, displayName: String, createdAt: Date) {
        self.id = id
        self.email = email
        self.displayName = displayName
        self.createdAt = createdAt
    }
}
