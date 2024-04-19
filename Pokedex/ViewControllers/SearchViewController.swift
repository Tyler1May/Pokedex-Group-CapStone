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
            guard let pokemon else { return }
            
                self.pokemon = pokemon
            
            // TODO: delete this
            let typeRelations = try? await PokemonController.getPokemonDamageRelatons("grass")
            if let typeRelations {
                
                print(typeRelations)
            }
            
            searchTableView.reloadData()
        }

    }
    
    @IBSegueAction func toDetailSegue(_ coder: NSCoder) -> PokemonDetailViewController? {
        return PokemonDetailViewController(coder: coder)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Perform the segue when a row is selected
            performSegue(withIdentifier: "toDetail", sender: nil)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetail" {
                // Get the destination view controller and set its properties if needed
                if let destinationVC = segue.destination as? PokemonDetailViewController {
                    if let selectedIndexPath = searchTableView.indexPathForSelectedRow {
                        destinationVC.pokemon = pokemon[selectedIndexPath.row]
                    }
                }
            }
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
