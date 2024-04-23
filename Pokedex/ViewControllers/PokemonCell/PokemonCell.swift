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

protocol UpdateCellDelegate: AnyObject {
    func didTapLikeButton(for pokemon: Pokemon)
}

class PokemonCell: UITableViewCell {
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    weak var delegate: UpdateCellDelegate?
    var fav = FavoriteController.shared
    var pokemon: Pokemon?
    var liked = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func update(with pokemon: Pokemon) {
        
        pokemonName.text = pokemon.name.capitalized
        pokemonNumber.text = "No. \(pokemon.id)"
        
        pokemonType.text = pokemon.types.reduce("") { "\($0 ?? "") \($1.type.name.capitalized)"}
        pokemonImage.load(url: pokemon.sprites.front_default)
        
        liked = pokemon.isFavorite ?? false
        updateLikeButton()
        self.pokemon = pokemon
        
    }
    
    @IBAction func favortieButton(_ sender: Any) {
        pokemon?.isFavorite = liked
        liked.toggle()
        updateLikeButton()
        
        if var pokemon = pokemon {
            pokemon.isFavorite = liked
            if liked {
                delegate?.didTapLikeButton(for: pokemon)
            } else {
                delegate?.didTapLikeButton(for: pokemon)
            }
        } else {
            print("Pokemon is nil")
        }
          
    }
    
    private func updateLikeButton() {
        let star = liked ? "star.fill" : "star"
        likeButton.setImage(UIImage(systemName: star), for: .normal)
        likeButton.tintColor = liked ? .systemYellow : .black
    }
    
}
