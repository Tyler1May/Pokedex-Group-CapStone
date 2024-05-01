//
//  MyTeamController.swift
//  Pokedex
//
//  Created by Hunter Jensen on 4/30/24.
//

import Foundation

class MyTeamController {
    
    static var shared = MyTeamController()
    
    var teamPokemon: [Pokemon] = []
    
    private let teamPokemonURL: URL = {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to get documents directory.")
        }
        return documentsDirectory.appendingPathComponent("favPokemon.plist")
    }()
    
    private init() {
        loadTeamPokemon()
    }
    
    func addTeamPokemon(_ pokemon: Pokemon) {
        if !teamPokemon.contains(where: { $0.id == pokemon.id }) {
            teamPokemon.append(pokemon)
            saveTeamPokemon()
        }
    }
    
    func removeTeamPokemon(_ pokemon: Pokemon) -> Bool {
        if let index = teamPokemon.firstIndex(where: { $0.id == pokemon.id }) {
            teamPokemon.remove(at: index)
            saveTeamPokemon()
            return true
        }
        return false
    }
    
    func isPokemonOnTeam(_ pokemon: Pokemon) -> Bool {
        return teamPokemon.contains(where: { $0.id == pokemon.id })
    }
    
    private func loadTeamPokemon() {
        if let data = try? Data(contentsOf: teamPokemonURL),
           let decodedPokemon = try? PropertyListDecoder().decode([Pokemon].self, from: data) {
            teamPokemon = decodedPokemon
        }
    }
    
    func saveTeamPokemon() {
        do {
            let encodePokemon = try PropertyListEncoder().encode(teamPokemon)
            try encodePokemon.write(to: teamPokemonURL)
        } catch {
            print("Error saving favorite Pokemon: \(error.localizedDescription)")
        }
    }
    
}
