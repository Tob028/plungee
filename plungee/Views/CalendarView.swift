//
//  StartView.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var databaseManager: DatabaseManager
    @State var sessions: [Session] = []
    
    var body: some View {
        ScrollView {
            HStack {
                Text("Your Sessions")
                    .font(.largeTitle)
                    .bold()
                    .frame(alignment: .leading)
                
                Spacer()
            }
            .padding(.horizontal, 30)
            
            VStack {
                ForEach(sessions) { session in
                    ListItem(session: session)
                }
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .onAppear {
            fetchSessionData()
        }
    }
    
    func fetchSessionData() {
        // fetch
        databaseManager.fetchSessionData { data in
            self.sessions = data
        }
    }
}

#Preview {
    CalendarView()
        .environmentObject(DatabaseManager.shared)
}

struct ListItem: View {
    let session: Session
    
    var body: some View {
        HStack {
            Text(session.exposureType.icon)
                .font(.largeTitle)
            
            VStack(alignment: .leading) {
                Text(formatStartDate())
                    .font(.title2)
                    .bold()
                
                Text("\(sessionDuration()) min")
                    .font(.headline)
            }
            
            Spacer()
        }
        .padding()
        .background(.gray.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
    }
    
    func formatStartDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/M/yyyy"
        return dateFormatter.string(from: session.startDate)
    }
    
    func sessionDuration() -> Int {
        return Int(session.endDate.timeIntervalSince(session.startDate) / 60)
    }
}
