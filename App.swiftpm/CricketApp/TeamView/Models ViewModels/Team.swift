//
//  Team.swift
//  App
//
//  Created by mridul-ziroh on 06/04/25.
//


//
//  Team.swift
//  ICC Cricket World Cup 2019
//
//  Created by mridul-ziroh on 06/04/25.
//
import Foundation

struct Team: Identifiable, Codable, Equatable {
    let id = UUID()
    let name: String
    let flag: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case flag
    }
}
