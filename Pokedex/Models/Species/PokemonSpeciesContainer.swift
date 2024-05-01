//
//  PokemonSpecies.swift
//  Pokedex
//
//  Created by shark boy on 4/26/24.
//

import Foundation

struct PokemonSpeciesContainer: Codable {
    
    let name: String
    
    let baseHappiness: Int?
    let captureRate: Int?
    
    let color: PokemonAttribute?
    let shape: PokemonAttribute?
    
    let isLegendary: Bool?
    let isMythical: Bool?
    
    let evolvesFrom: PokemonSpecies?
    let habitat: PokemonHabitat?
    
    enum CodingKeys: String, CodingKey {
        case isLegendary = "is_legendary", isMythical = "is_mythical", evolvesFrom = "evolves_from_species", baseHappiness = "base_happiness", captureRate = "capture_rate", name, habitat, color, shape
    }
}


struct PokemonHabitat: Codable {
    let name: String
    let url: String
}
