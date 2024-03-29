//
//  SessionView.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import SwiftUI

struct SessionView: View {
    var body: some View {
        VStack {
            Text("time")
            Text("heart rate")
            Text("temp")
            Text("calories")
            
            HStack {
                Text("pause/resume")
                Text("end")
            }
        }
    }
}

#Preview {
    SessionView()
}
