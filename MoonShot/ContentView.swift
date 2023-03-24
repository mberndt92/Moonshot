//
//  ContentView.swift
//  MoonShot
//
//  Created by Maximilian Berndt on 2023/03/22.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showAsGrid = false
    
    var body: some View {
        NavigationView {
            Group {
                if showAsGrid {
                    MissionViewGrid(
                        missions: missions,
                        astronauts: astronauts
                    )
                } else {
                    MissionViewList(
                        missions: missions,
                        astronauts: astronauts
                    )
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    showAsGrid.toggle()
                } label: {
                    Text(showAsGrid ? "Show As List" : "Show as Grid")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
