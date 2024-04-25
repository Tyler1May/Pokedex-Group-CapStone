//
//  Pokemon.swift
//  Pokedex
//
//  Created by Brayden Lemke on 1/10/24.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    var name: String
    var types: [PokemonTypeContainer]
    var sprites: PokemonSprites
    var id: Int
    var stats: [PokemonStatsContainer]
    
    }

struct PokemonStatsContainer: Codable {
    var baseStat: Int
    
    var stat: PokemonStat
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct PokemonStat: Codable {
    var name: String
}
