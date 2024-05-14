//
//  PokemonSprites.swift
//  Pokedex
//
//  Created by Brayden Lemke on 1/10/24.
//

import Foundation

struct PokemonSprites: Codable {
    var front_default: URL
    var back_default: URL
    var front_shiny: URL
    var back_shiny: URL
}

extension PokemonSprites: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(front_default)
        hasher.combine(back_default)
        hasher.combine(front_shiny)
        hasher.combine(back_shiny)
    }
}

extension PokemonSprites {
    static var testSprites: PokemonSprites {
        PokemonSprites(front_default: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!,
                       back_default: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png")!,
                       front_shiny: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png")!,
                       back_shiny: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png")!)
    }
}
