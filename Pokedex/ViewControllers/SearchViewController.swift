//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Tyler May on 4/16/24.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UpdateCellDelegate {
    
    func didTapTeamButton(for pokemon: Pokemon) {
        if team.isPokemonOnTeam(pokemon) {
            _ = team.removeTeamPokemon(pokemon)
        } else {
            let success = team.addTeamPokemon(pokemon)
            if success {
                
            } else {
                showAlertWith(title: "Team Full", message: "You cannot add more than 6 Pokémon to your team.")
            }
        }
    }
    
    func showAlertWith(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
   

    
    @IBOutlet var searchTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    typealias myTeamDiffableDataSource = UITableViewDiffableDataSource<Int, Pokemon>
    var myTeamdataSource: myTeamDiffableDataSource!
    
    typealias PokemonDiffableDataSource = UITableViewDiffableDataSource<Int, Pokemon>
    var dataSource: PokemonDiffableDataSource!
    var pokemon: [Pokemon] = []
    var fav = FavoriteController.shared
    let team = MyTeamController.shared
    var filteredPokemon: [Pokemon] = []
    var isSearching = false
    
    var isFetchingPokemon = false
    var hasMorePokemon = true
    var pageNumber = 0

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
            
            let lastSectionIndex = tableView.numberOfSections - 1
                  let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
                  if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
                    let spinner = UIActivityIndicatorView(style: .large)
                    spinner.frame = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 70)
                    if self.isSearching {
                      spinner.stopAnimating()
                      tableView.tableFooterView = nil
                    } else {
                      spinner.startAnimating()
                      tableView.tableFooterView = spinner
                    }
                  }
                  if indexPath.row == self.pokemon.count - 1 {
                    self.pageNumber += 1
                      self.displayGenericPokemon(self.pageNumber)
                  }
            
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
        
    private func displayGenericPokemon(_ page: Int  = 0) {
        guard !isFetchingPokemon, hasMorePokemon else { return }
        isFetchingPokemon = true
        Task {

          do {
            let newPokemon = try await PokemonController.getGenericPokemon(page: page)
            print("page: \(pageNumber) with \(self.pokemon.count) many pokemon")
            if newPokemon.count < 20 {
              hasMorePokemon = false

            }
            DispatchQueue.main.async {
              if newPokemon.isEmpty {
                self.hasMorePokemon = false
              } else {
                self.pokemon.append(contentsOf: newPokemon)
                self.applySnapshot()
              }
              self.isFetchingPokemon = false
            }
          } catch {
            DispatchQueue.main.async {
              self.isFetchingPokemon = false
            }
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
        if isSearching {
            return filteredPokemon.count
        } else {
            return pokemon.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        let pokemon = isSearching ? filteredPokemon[indexPath.row] : self.pokemon[indexPath.row]
        cell.update(with: pokemon)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = isSearching ? filteredPokemon[indexPath.row] : self.pokemon[indexPath.row]
        Task {
            do {
                let species = try await PokemonController.getPokemonSpecies(selectedPokemon.id)
                let evo = try? await PokemonController.getEvolutionChain(species?.evoChain.url)
                
                performSegue(withIdentifier: "toDetail", sender: (selectedPokemon, evo, species))
            } catch {
                print("Error fetching evolution Chain: \(error.localizedDescription)")
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let destinationVC = segue.destination as? PokemonDetailViewController {
                if let sender = sender as? (Pokemon, PokemonEvolutionContainer, PokemonSpeciesContainer) {
                    destinationVC.pokemon = sender.0
                    destinationVC.evo = sender.1
                    destinationVC.species = sender.2
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

