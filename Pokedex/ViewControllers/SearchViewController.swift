//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Tyler May on 4/16/24.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var searchTableView: UITableView!
    
    var pokemon: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayGenericPokemon()
        
        searchTableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "PokemonCell")
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.reloadData()
        
    }
    
    func displayGenericPokemon() {
        Task {
            let pokemon = try? await PokemonController.getGenericPokemon()
            self.pokemon = pokemon!
            searchTableView.reloadData()
        }
    }
    

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        
        cell.update(with: pokemon[indexPath.row])
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // If the text is empty bring the generic pokemon back to the screen
        if searchBar.text ?? "" == "" {
            displayGenericPokemon()
            return
        }
        
        // Display the searched pokemon
        Task {
            do {
                if let searchedPokemon = try await PokemonController.getSpecificPokemon(pokemonName: searchBar.text ?? "") {
                    pokemon = [searchedPokemon]
                    searchTableView.reloadData()
                }
            } catch {
                // TODO: Handle errors
                print(error)
            }
        }
    }
    
    
    
}
