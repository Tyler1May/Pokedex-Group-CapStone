//
//  EvolutionChain.swift
//  Pokedex
//
//  Created by shark boy on 4/22/24.
//

import Foundation


struct PokemonEvolutionContainer: Codable, Hashable {
    let chain: EvolutionChain
    let id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(chain)
        hasher.combine(id)
    }
}

struct EvolutionChain: Codable, Hashable {
    let evolvesTo: [EvolutionChain?]
    let species: SpeciesContainer
    
    enum CodingKeys: String, CodingKey {
        case evolvesTo = "evolves_to"
        case species
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(evolvesTo)
        hasher.combine(species)
    }
}

struct SpeciesContainer: Codable, Hashable {
    let name: String
    let url: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(url)
    }
}
