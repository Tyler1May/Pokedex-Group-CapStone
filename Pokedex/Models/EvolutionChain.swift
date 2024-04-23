//
//  EvolutionChain.swift
//  Pokedex
//
//  Created by shark boy on 4/22/24.
//

import Foundation


struct PokemonEvolutionContainer: Codable {
    
    let chain: EvolutionChain
    let id: Int
    

}
struct EvolutionChain: Codable {

    let evolvesTo: [EvolutionChain?]
    
    let species: SpeciesContainer
    
    enum CodingKeys: String, CodingKey {
        
        case evolvesTo = "evolves_to"
        
        case species
    }
}
struct SpeciesContainer: Codable {
    let name: String
    let url: String
}
