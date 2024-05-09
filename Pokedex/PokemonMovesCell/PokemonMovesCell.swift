//
//  PokemonMovesCell.swift
//  Pokedex
//
//  Created by Tyler May on 5/8/24.
//

import UIKit

class PokemonMovesCell: UITableViewCell {

    @IBOutlet var moveNameLabel: UILabel!
    @IBOutlet var moveTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func update(with moves: PokemonMovesContainer) {
        moveNameLabel.text = moves.move.name?.capitalized
//        moveNameLabel.setPokemonFont(size: 10)
    }

}
