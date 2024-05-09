//
//  MyTeamTableViewCell.swift
//  Pokedex
//
//  Created by Hunter Jensen on 4/29/24.
//

import UIKit

class MyTeamTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonNOLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var myTeamButton: UIButton!
    
    
    weak var delegate: UpdateCellDelegate?
    var team = MyTeamController.shared
    var pokemon: Pokemon?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func didTapTeamButton(for pokemon: Pokemon) {
        if !team.isPokemonOnTeam(pokemon) {
            _ = team.addTeamPokemon(pokemon)
        } else {
            _ = team.removeTeamPokemon(pokemon)
        }
        
    }
    @IBAction func myTeamButtonTapped(_ sender: Any) {
        
        if let pokemon = pokemon {
            if !team.isPokemonOnTeam(pokemon) {
                delegate?.didTapTeamButton(for: pokemon)
            } else {
                delegate?.didTapTeamButton(for: pokemon)
            }
        } else {
            print("Pokemon is nil")
        }
        
        
    }
    
    func update(with pokemon: Pokemon) {
        
        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonNameLabel.font = UIFont(name: "PokemonGb", size: 15)
        pokemonNOLabel.text = "No. \(pokemon.id)"
        pokemonNOLabel.font = UIFont(name: "PokemonGb", size: 10)
        pokemonTypeLabel.text = pokemon.types.reduce("") { "\($0 ?? "") \($1.type.name.capitalized)"}
        pokemonTypeLabel.font = UIFont(name: "PokemonGb", size: 10)
        pokemonImageView.load(url: pokemon.sprites.front_default)
        
        self.pokemon = pokemon
        
        
        
    }

        
//    private func updateTeamButton() {
//        let pokeball = team.teamPokemon.contains(where: { $0.id == pokemon?.id }) ? "pokeball.fill" : "pokeball"
//        myTeamButton.setImage(UIImage(systemName: pokeball), for: .normal)
//        
//    }
    
}
