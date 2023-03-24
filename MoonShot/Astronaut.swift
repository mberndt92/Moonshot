//
//  Astronaut.swift
//  MoonShot
//
//  Created by Maximilian Berndt on 2023/03/23.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    
    static var test: Astronaut {
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        return astronauts["aldrin"]!
    }
}
