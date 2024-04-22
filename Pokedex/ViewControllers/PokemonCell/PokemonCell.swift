//
//  PokemonCell.swift
//  Pokedex
//
//  Created by shark boy on 4/16/24.
//

import Foundation
import UIKit

//let postNib = UINib.init(nibName: "PokemonCell", bundle: nil)
//self.postsTableView.register(postNib, forCellReuseIdentifier: "PokemonCell")
// call in init to register nib


class PokemonCell: UITableViewCell {
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(with pokemon: Pokemon) {
        
        pokemonName.text = pokemon.name.capitalized
        pokemonNumber.text = "No. \(pokemon.id)"
        
        pokemonType.text = pokemon.types.reduce("") { "\($0 ?? "") \($1.type.name.capitalized)"}
        pokemonImage.load(url: pokemon.sprites.front_default)
    }
    
    @IBAction func favortieButton(_ sender: Any) {
        
    }
    
}