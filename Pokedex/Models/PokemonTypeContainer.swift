//
//  PokemonTypeContainer.swift
//  Pokedex
//
//  Created by Brayden Lemke on 1/10/24.
//

import Foundation

struct PokemonTypeContainer: Codable {
    var slot: Int
    var type: PokemonType

}

extension PokemonTypeContainer: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(slot)
        hasher.combine(type)
    }
}

extension PokemonTypeContainer {
    static var testPokemonTypeContainer: PokemonTypeContainer {
        PokemonTypeContainer(slot: 1, type: PokemonType.testPokemonType)
    }
}
