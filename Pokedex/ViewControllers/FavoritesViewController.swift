//
//  FavoritesViewController.swift
//  Pokedex
//
//  Created by Tyler May on 4/22/24.
//

import UIKit

class FavoritesViewController: UIViewController, UISearchBarDelegate, UpdateCellDelegate {

    @IBOutlet var favoriteTableView: UITableView!
    
    let fav = FavoriteController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteTableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "PokemonCell")
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteTableView.reloadData()
    }
    
    func didTapLikeButton(for pokemon: Pokemon) {
        if pokemon.isFavorite! {
            fav.addFavoritePokemon(pokemon)
        } else {
            fav.removeFavoritePokemon(pokemon)
        }
        favoriteTableView.reloadData()
    }
    
    @IBSegueAction func toDetailSegue(_ coder: NSCoder) -> UIViewController? {
        return PokemonDetailViewController(coder: coder)
    }
        

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fav.favPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        
        let pokemon = fav.favPokemon[indexPath.row]
        cell.update(with: pokemon)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "toDetail", sender: nil)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetail" {
                if let destinationVC = segue.destination as? PokemonDetailViewController {
                    if let selectedIndexPath = favoriteTableView.indexPathForSelectedRow {
                        destinationVC.pokemon = fav.favPokemon[selectedIndexPath.row]
                    }
                }
            }
        }
    
    
}
