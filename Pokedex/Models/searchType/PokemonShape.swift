//
//  PokemonShape.swift
//  Pokedex
//
//  Created by shark boy on 4/23/24.
//

import Foundation

struct PokemonShape {
    
    
    enum pokeShape: String  {
        case ball, squiggle, fish, arms, blob, upright, legs, quadruped, wings, tentacles, heads, humanoid, bugWings = "bug-wings", armor
    }
}

extension CaseIterable where Self: Equatable {
    var index: Self.AllCases.Index? {
        return Self.allCases.firstIndex { self == $0 }
    }
}
