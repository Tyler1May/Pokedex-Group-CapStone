//
//  PokemonType.swift
//  Pokedex
//
//  Created by Brayden Lemke on 1/10/24.
//

import Foundation

struct PokemonType: Codable {
    var name: String
    var url: String?
    
}

extension PokemonType: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(url)
    }
}

extension PokemonType {
    static var testPokemonType: PokemonType {
        PokemonType(name: "grass", url: "https://pokeapi.co/api/v2/type/12/")
    }
}

