//
//  StartView.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import SwiftUI

struct CalendarView: View {
    let sessions: [Session] = [
        Session(exposureType: .plunge, startDate: Date(), endDate: Date(), events: [], statistics: []),
        Session(exposureType: .shower, startDate: Date(), endDate: Date(), events: [], statistics: []),
        Session(exposureType: .sauna, startDate: Date(), endDate: Date(), events: [], statistics: []),
        Session(exposureType: .plunge, startDate: Date(), endDate: Date(), events: [], statistics: []),
        Session(exposureType: .sauna, startDate: Date(), endDate: Date(), events: [], statistics: [])
    ]
    
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
    }
}

#Preview {
    CalendarView()
}

struct ListItem: View {
    let session: Session
    
    var body: some View {
        HStack {
            Text(session.exposureType.icon)
                .font(.largeTitle)
            
            VStack(alignment: .leading) {
                Text("16/2/2024")
                    .font(.title2)
                    .bold()
                
                Text("20 min")
                    .font(.headline)
            }
            //.padding()
            
            Spacer()
        }
        .padding()
        .background(.gray.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
    }
}
