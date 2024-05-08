//
//  TeamDetailViewController.swift
//  Pokedex
//
//  Created by Hunter Jensen on 5/8/24.
//

import UIKit

class TeamDetailViewController: UIViewController {

    var pokemon: Pokemon?
       
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var noLabel: UILabel!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
       
        
           configureWithPokemon()
       }

    
       private func configureWithPokemon() {
           guard let pokemon = pokemon else { return }
           nameLabel.text = pokemon.name
           nameLabel.font = UIFont(name: "PokemonGb" , size: 18)
           imageView.load(url: pokemon.sprites.front_default)
           noLabel.text = "No. \(pokemon.id)"
           typeLabel.text = pokemon.types.map { $0.type.name }.joined(separator: ", ")
           
       }
    

    

}
