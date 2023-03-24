//
//  MissionView.swift
//  MoonShot
//
//  Created by Maximilian Berndt on 2023/03/24.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
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
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding()
                    
                    Text(mission.formattedLaunchDate)
                        .font(.title2)
                    
                    VStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        Text(mission.description)
                            .font(.body)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                        VStack() {
                            Text("Crew")
                                .font(.title.bold())
                                .padding(.bottom, 5)
                            
                        }
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crew in
                                NavigationLink {
                                    AstronautView(astronaut: crew.astronaut)
                                } label: {
                                    HStack {
                                        Image(crew.astronaut.id)
                                            .resizable()
                                            .frame(width: 104, height: 72)
                                            .cornerRadius(15)
                                        VStack(alignment: .leading) {
                                            Text(crew.astronaut.name)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                            Text(crew.role)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding(.trailing)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(.white.opacity(0.7), lineWidth: 1)
                                    }
                                    .padding(.leading)
                                }
                                
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
