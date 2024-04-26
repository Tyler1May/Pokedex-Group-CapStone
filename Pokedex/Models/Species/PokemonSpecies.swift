//
//  PokemonSpecies.swift
//  Pokedex
//
//  Created by shark boy on 4/26/24.
//

import Foundation

struct PokemonSpecies: Decodable {
    let color: PokemonColor
    let shape: PokemonShape
    
    let isLegendary: Bool
    let isMythical: Bool
    
    enum codingKeys: String, CodingKey {
        case isLegendary = "is_Legendary", isMythical = "is_Mythical"
    }
}
