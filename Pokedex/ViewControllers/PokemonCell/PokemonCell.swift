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
    func didTapTeamButton(for pokemon: Pokemon)
}

class PokemonCell: UITableViewCell {
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var myTeamButton: UIButton!
    
    weak var delegate: UpdateCellDelegate?
    var fav = FavoriteController.shared
    var pokemon: Pokemon?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func update(with pokemon: Pokemon) {
        
        pokemonName.text = pokemon.name.capitalized
        pokemonNumber.text = "No. \(pokemon.id)"
        
        pokemonType.text = pokemon.types.reduce("") { "\($0 ?? "") \($1.type.name.capitalized)"}
        pokemonImage.load(url: pokemon.sprites.front_default)
        
        self.pokemon = pokemon
        updateLikeButton()
        
    }
    
    
    @IBAction func addToTeamButtonTapped(_ sender: Any) {
        if let pokemon = pokemon {
            delegate?.didTapTeamButton(for: pokemon)
        } else {
            print("Nope")
        }
    }
    
    @IBAction func favortieButton(_ sender: Any) {
        
        if let pokemon = pokemon {
            if !fav.isPokemonFavorite(pokemon) {
                delegate?.didTapLikeButton(for: pokemon)
            } else {
                delegate?.didTapLikeButton(for: pokemon)
            }
        } else {
            print("Pokemon is nil")
        }
        updateLikeButton()
          
    }
    
    private func updateLikeButton() {
        let star = fav.favPokemon.contains(where: { $0.id == pokemon?.id }) ? "star.fill" : "star"
        likeButton.setImage(UIImage(systemName: star), for: .normal)
        likeButton.tintColor = fav.favPokemon.contains(where: { $0.id == pokemon?.id}) ? .systemYellow : .black
    }
    
}
