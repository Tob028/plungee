//
//  StartView.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Start")
            
            VStack {
                List(workoutTypes) { workoutType in
                    Text(workoutType.id)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
