//
//  MyTeam.swift
//  Pokedex
//
//  Created by Hunter Jensen on 4/25/24.
//

import Foundation

struct Team: Codable {
    var pokemons: [Pokemon]
    
    static let maximumTeamSize = 6
    
    mutating func addPokemon(_ pokemon: Pokemon) -> Bool {
        if pokemons.count < Team.maximumTeamSize {
            pokemons.append(pokemon)
            return true
        } else {
            return false  
        }
    }
    
    mutating func removePokemon(at index: Int) {
        guard pokemons.indices.contains(index) else { return }
        pokemons.remove(at: index)
    }
}
