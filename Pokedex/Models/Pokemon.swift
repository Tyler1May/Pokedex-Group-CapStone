//
//  Pokemon.swift
//  Pokedex
//
//  Created by Brayden Lemke on 1/10/24.
//

import Foundation

struct Pokemon: Codable {
    var name: String
    var types: [PokemonTypeContainer]
    var sprites: PokemonSprites
    var id: Int
    var stats: [PokemonStatsContainer]
    
    enum codingKeys: String, CodingKey {
        case stats = "stats"
    }
}

struct PokemonStatsContainer: Codable {
    var baseStat: Int?
    
    var stat: PokemonStat
//    
    enum codingKeys: String, CodingKey {
        case baseStat = "base_stat"
    }
}

struct PokemonStat: Codable {
    var name: String
}
