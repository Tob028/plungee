//
//  DashboardView.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import SwiftUI

struct DashboardView: View {
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .trailing) {
                    Text("Hi, John!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Your Statistics")
                        .font(.title2)
                }
                
                Spacer()
            }
            .padding(.top, 50)
            
            // Placeholder for the chart
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 200)
                .overlay(
                    ZStack {
                        Text("PREVIEW")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.5))
                        
                        VStack {
                            HStack {
                                Text("Minutes spent plunging")
                                    .fontWeight(.bold)
                                    .padding([.top, .leading], 10)
                                
                                Spacer()
                            }
                            
                            Spacer()
                            
                            LineChartPlaceholder()
                                .stroke(Color.black, lineWidth: 2)
                                .padding()

                        }
                    }
                )
                .padding(.top, 20)
            
            Spacer()
        }
        .padding()
    }
}

struct LineChartPlaceholder: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addCurve(to: CGPoint(x: rect.maxX, y: rect.minY),
                      control1: CGPoint(x: rect.width * 0.25, y: rect.minY),
                      control2: CGPoint(x: rect.width * 0.75, y: rect.maxY))
        
        return path
    }
}

#Preview {
    DashboardView().environmentObject(WatchConnector())
}
