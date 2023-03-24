//
//  CrewView.swift
//  MoonShot
//
//  Created by Maximilian Berndt on 2023/03/25.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct CrewView: View {
    
    let crew: [CrewMember]
    
    var body: some View {
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

struct CrewView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        CrewView(crew: [
            CrewMember(role: "captain", astronaut: Astronaut.test),
            CrewMember(role: "lunar commander", astronaut: Astronaut.test),
            CrewMember(role: "engineer", astronaut: Astronaut.test)
        ])
            .preferredColorScheme(.dark)
    }
}
