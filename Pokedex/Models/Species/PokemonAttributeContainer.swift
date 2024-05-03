//
//  PokemonColor.swift
//  Pokedex
//
//  Created by shark boy on 4/26/24.
//

import Foundation

// TODO: list in comments every URL query/attribute that decodes to this type

struct PokemonAttributeContainer: Codable {
    let id: Int
    let name: String
    let pokemonSpecies: [PokemonSpecies?]
    enum CodingKeys: String, CodingKey {
        case pokemonSpecies = "pokemon_species", name, id
    }
}



