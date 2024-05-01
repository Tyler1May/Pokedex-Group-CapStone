//
//  Moves.swift
//  Pokedex
//
//  Created by shark boy on 4/26/24.
//

import Foundation

struct PokemonMoveContainer: Codable {
    let move: Move
}

struct Move: Codable {
    let name: String?
    let url: String?
    
}
