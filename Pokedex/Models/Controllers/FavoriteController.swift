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
    
    private let favPokemonURL: URL = {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to get documents directory.")
        }
        return documentsDirectory.appendingPathComponent("favPokemon.plist")
    }()
    
    private init() {
        loadFavoritePokemon()
    }
    
    func addFavoritePokemon(_ pokemon: Pokemon) {
        if !favPokemon.contains(where: { $0.id == pokemon.id }) {
            favPokemon.append(pokemon)
            saveFavoritePokemon()
        }
    }
    
    func removeFavoritePokemon(_ pokemon: Pokemon) -> Bool {
        if let index = favPokemon.firstIndex(where: { $0.id == pokemon.id }) {
            favPokemon.remove(at: index)
            saveFavoritePokemon()
            return true
        }
        return false
    }
    
    func isPokemonFavorite(_ pokemon: Pokemon) -> Bool {
        return favPokemon.contains(where: { $0.id == pokemon.id })
    }
    
    private func loadFavoritePokemon() {
        if let data = try? Data(contentsOf: favPokemonURL),
           let decodedPokemon = try? PropertyListDecoder().decode([Pokemon].self, from: data) {
            favPokemon = decodedPokemon
        }
    }
    
    func saveFavoritePokemon() {
        do {
            let encodePokemon = try PropertyListEncoder().encode(favPokemon)
            try encodePokemon.write(to: favPokemonURL)
        } catch {
            print("Error saving favorite Pokemon: \(error.localizedDescription)")
        }
    }
    
}

