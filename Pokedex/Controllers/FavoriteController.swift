//
//  FavoriteController.swift
//  Pokedex
//
//  Created by Tyler May on 4/23/24.
//

import Foundation

class FavoriteController {
    
    static var shared = FavoriteController()
    
    var favPokemon: [Pokemon] = []
    
    func addFavoritePokemon(_ pokemon: Pokemon) {
        if !favPokemon.contains(where: { $0.id == pokemon.id }) {
            favPokemon.append(pokemon)
        }
    }
    
    func removeFavoritePokemon(_ pokemon: Pokemon) -> Bool {
        if let index = favPokemon.firstIndex(where: { $0.id == pokemon.id }) {
            favPokemon.remove(at: index)
            return true
        }
        return false
    }
    
    func isPokemonFavorite(_ pokemon: Pokemon) -> Bool {
        return favPokemon.contains(where: { $0.id == pokemon.id })
    }
}

