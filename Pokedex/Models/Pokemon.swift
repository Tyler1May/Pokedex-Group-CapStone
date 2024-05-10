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
    var moves: [PokemonMovesContainer]
    
    static func==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(name: String, types: [PokemonTypeContainer], sprites: PokemonSprites, id: Int, stats: [PokemonStatsContainer], moves: [PokemonMovesContainer]) {
        self.name = name
        self.types = types
        self.sprites = sprites
        self.id = id
        self.stats = stats
        self.moves = moves
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
