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



















//struct PokemonColor: Codable {
//    
//    let color: PokeColor
//    
//    enum PokeColor: String, Codable {
//        case black, blue, brown, gray, green, pink, purple, red, white, yellow
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case color = "name"
//        
//        
//    }
//}


