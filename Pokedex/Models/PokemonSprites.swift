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
