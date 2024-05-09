//
//  PixelFont.swift
//  Pokedex
//
//  Created by Tyler May on 5/9/24.
//

import Foundation
import UIKit

extension UILabel {
    func setPokemonFont(size: CGFloat) {
        if let pokemonFont = UIFont(name: "PokemonGb", size: size) {
            self.font = pokemonFont
        } else {
            self.font = UIFont.systemFont(ofSize: size)
        }
    }
}
