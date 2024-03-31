//
//  StartView.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import SwiftUI

struct HomeView: View {
    @State var presentedWorkout: [ExposureType] = []
    
    var body: some View {
        NavigationStack(path: $presentedWorkout) {
            VStack {
                ForEach(exposureTypes) { workoutType in
                    NavigationLink(workoutType.id, value: workoutType)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .font(.system(size: 26, weight: .medium, design: .default))
                        .background(.gray)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .navigationDestination(for: ExposureType.self) { workoutType in
                            SessionView()
                                .toolbar(.hidden)
                        }
                        .onChange(of: presentedWorkout) {
                            guard let workout = presentedWorkout.last else { return }
                            //workoutManager.selectedWorkout = workout
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
}

#Preview {
    HomeView()
}
