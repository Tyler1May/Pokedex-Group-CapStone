//
//  PokemonSearchTableViewController.swift
//  Pokedex
//
//  Created by Brayden Lemke on 1/10/24.
//

import UIKit

class PokemonSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    
    
    
    var pokemon: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        

        displayGenericPokemon()
    }
    
    func displayGenericPokemon() {
        Task {
            let pokemon = try? await PokemonController.getGenericPokemon()
            self.pokemon = pokemon!
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemon.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonTableViewCell
        
        cell.setup(pokemon: pokemon[indexPath.row])

        return cell
    }
    
    
    @IBSegueAction func pokemonDetailSegueAction(_ coder: NSCoder) -> PokemonDetailViewController? {
        return PokemonDetailViewController(pokemon: pokemon[tableView.indexPathForSelectedRow!.row], coder: coder)
    }
    
    // MARK: - UISearchBar Delegate Methods
    


}
