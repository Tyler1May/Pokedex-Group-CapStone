//
//  FavoritesViewController.swift
//  Pokedex
//
//  Created by Tyler May on 4/22/24.
//

import UIKit

class FavoritesViewController: UIViewController, UISearchBarDelegate, UpdateCellDelegate {

    @IBOutlet var favoriteTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    let fav = FavoriteController.shared
    var filteredFavorites: [Pokemon] = []
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteTableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "PokemonCell")
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        favoriteTableView.reloadData()
        
        searchBar.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteTableView.reloadData()
    }
    
    func didTapLikeButton(for pokemon: Pokemon) {
        if !fav.isPokemonFavorite(pokemon) {
            fav.addFavoritePokemon(pokemon)
        } else {
            _ = fav.removeFavoritePokemon(pokemon)
        }
        favoriteTableView.reloadData()
    }
    
    @IBSegueAction func toDetailSegue(_ coder: NSCoder) -> UIViewController? {
        return PokemonDetailViewController(coder: coder)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            favoriteTableView.reloadData()
        } else {
            isSearching = true
            filteredFavorites = fav.favPokemon.filter( {$0.name.lowercased().contains(searchText.lowercased())} )
            favoriteTableView.reloadData()
        }
    }
        

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredFavorites.count
        } else {
            return fav.favPokemon.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        
        cell.delegate = self
        let pokemon: Pokemon
        if isSearching {
            pokemon = filteredFavorites[indexPath.row]
        } else {
            pokemon = fav.favPokemon[indexPath.row]
        }
        cell.update(with: pokemon)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "toDetail", sender: nil)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetail" {
                if let destinationVC = segue.destination as? PokemonDetailViewController {
                    if let selectedIndexPath = favoriteTableView.indexPathForSelectedRow {
                        let pokemon: Pokemon
                        if isSearching {
                            pokemon = filteredFavorites[selectedIndexPath.row]
                        } else {
                            pokemon = fav.favPokemon[selectedIndexPath.row]
                        }
                        destinationVC.pokemon = pokemon
                    }
                }
            }
        }
    
    
}
