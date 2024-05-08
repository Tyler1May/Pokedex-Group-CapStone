//
//  Moves.swift
//  Pokedex
//
//  Created by shark boy on 4/26/24.
//

import Foundation

struct PokemonMovesContainer: Codable {
    let move: Move
}

struct Move: Codable {
    let name: String?
    let url: String? 
}

struct PokemonMoveDetail: Codable {
    let accuracy: Int
    let damageClass: DamageClass
    let type: MoveType
    
    enum CodingKeys: String, CodingKey {
        case accuracy
        case damageClass = "damage_class"
        case type
    }
}

struct DamageClass: Codable {
    let name: String
    let url: URL
}

struct MoveType: Codable {
    let name: String
    let url: URL
}
