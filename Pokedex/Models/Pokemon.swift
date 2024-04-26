//
//  Pokemon.swift
//  Pokedex
//
//  Created by Brayden Lemke on 1/10/24.
//

import Foundation

struct Pokemon: Codable, Identifiable, Equatable {
    
    var name: String
    var types: [PokemonTypeContainer]
    var sprites: PokemonSprites
    var id: Int
    var stats: [PokemonStatsContainer]
    var moves: [PokemonMoveContainer]
    
    static func==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
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

extension Pokemon: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(types)
        hasher.combine(sprites)
        hasher.combine(id)
        hasher.combine(stats)
    }
}

extension PokemonStatsContainer: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(baseStat)
        hasher.combine(stat)
    }
}

extension PokemonStat: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
