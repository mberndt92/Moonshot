//
//  MissionView.swift
//  MoonShot
//
//  Created by Maximilian Berndt on 2023/03/24.
//

import SwiftUI

struct MissionViewDetails: View {
    
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            guard let astronaut = astronauts[member.name] else {
                fatalError("Missing \(member.name)")
            }
            
            return CrewMember(role: member.role, astronaut: astronaut)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(decorative: mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding()
                    
                    Text(mission.formattedLaunchDate)
                        .font(.title2)
                        .accessibilityLabel(mission.formattedLaunchDate == "N/A" ? "\(mission.displayName) did not launch" : "\(mission.displayName) launched on \(mission.formattedLaunchDate)")
                    
                    VStack(alignment: .leading) {
                        CustomDivider()
                        
                        VStack {
                            Text("Mission Highlights")
                                .font(.title.bold())
                                .padding(.bottom, 5)
                            Text(mission.description)
                                .font(.body)
                        }
                        .accessibilityElement()
                        .accessibilityLabel("Mission Highlights")
                        .accessibilityHint(mission.description)
                        
                        CustomDivider()
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    CrewView(crew: crew)
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionViewDetails_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionViewDetails(mission: missions[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
