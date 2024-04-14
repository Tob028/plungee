//
//  StartView.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var body: some View {
        VStack {
            VStack {
                Text("Start")
                //Text("cold!")
            }
            .font(.system(size: 34, weight: .heavy, design: .default))
            
            ForEach(exposureTypes) { workoutType in
                NavigationLink(workoutType.id, value: workoutType)
                    .padding(EdgeInsets(top: 17, leading: 40, bottom: 17, trailing: 40))
                    .font(.system(size: 26, weight: .medium, design: .default))
                    .background(.black.opacity(0.8))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 35, style: .circular))
                    .navigationDestination(for: ExposureType.self) { exposureType in
                        SessionView(selectedExposureType: exposureType)
                    }
            }
            .navigationTitle("plungee")
            .navigationBarTitleDisplayMode(.large)
            .onAppear() {
                //workoutManager.requestAuthorisation()
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(WorkoutManager())
}
