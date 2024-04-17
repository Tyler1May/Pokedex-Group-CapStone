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
            var pokemon = try? await PokemonController.getGenericPokemon()
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
    
    
}
