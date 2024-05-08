//
//  PokemonMovesCell.swift
//  Pokedex
//
//  Created by Tyler May on 5/8/24.
//

import UIKit

class PokemonMovesCell: UITableViewCell {

    @IBOutlet var moveNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func update(with moves: PokemonMoveContainer) {
        moveNameLabel.text = moves.move.name?.capitalized
    
    }

}
