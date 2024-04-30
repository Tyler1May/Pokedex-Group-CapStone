//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Tyler May on 4/16/24.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UpdateCellDelegate {
    
    @IBOutlet var searchTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    typealias PokemonDiffableDataSource = UITableViewDiffableDataSource<Int, Pokemon>
    var dataSource: PokemonDiffableDataSource!
    var pokemon: [Pokemon] = []
    var fav = FavoriteController.shared
    var filteredPokemon: [Pokemon] = []
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureDataSource()
        displayGenericPokemon()
        
        searchBar.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchTableView.reloadData()
    }
    
    func configureTableView() {
        searchTableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "PokemonCell")
        searchTableView.delegate = self
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, Pokemon>(tableView: searchTableView) { tableView, indexPath, pokemon in
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
            cell.update(with: pokemon)
            cell.delegate = self
            return cell
        }
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Pokemon>()
        snapshot.appendSections([0])
        snapshot.appendItems(isSearching ? filteredPokemon : pokemon)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
        
    
    func displayGenericPokemon() {
        Task {
            do {
                
                let species = try await PokemonController.getPokemonSpecies(1)
                print(species)
                
                let pokemon = try await PokemonController.getGenericPokemon()
                self.pokemon = pokemon
                applySnapshot()
            } catch {
                print("error fetching Generic Pokemon: \(error.localizedDescription)")
            }
        }
    }
    
    func didTapLikeButton(for pokemon: Pokemon) {
        if !fav.isPokemonFavorite(pokemon) {
            fav.addFavoritePokemon(pokemon)
        } else {
            _ = fav.removeFavoritePokemon(pokemon)
        }
        searchTableView.reloadData()
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
        let pokemon = isSearching ? filteredPokemon[indexPath.row] : self.pokemon[indexPath.row]
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
                    if let selectedIndexPath = searchTableView.indexPathForSelectedRow {
                        destinationVC.pokemon = pokemon[selectedIndexPath.row]
                    }
                }
            }
        }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            Task {
                do {
                    if let searchedPokemon = try await PokemonController.getSpecificPokemon(pokemonName: searchText) {
                        isSearching = true
                        filteredPokemon = [searchedPokemon]
                        applySnapshot()
                    }
                } catch {
                    print("Error searching Pokemon: \(error.localizedDescription)")
                }
            }
        } else {
            isSearching = false
            displayGenericPokemon()
        }
    }
    
}

