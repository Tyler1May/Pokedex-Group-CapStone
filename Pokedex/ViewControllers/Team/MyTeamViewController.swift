//
//  MyTeamViewController.swift
//  Pokedex
//
//  Created by Tyler May on 4/16/24.
//

import UIKit

class MyTeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UpdateCellDelegate {
    
    func didTapLikeButton(for pokemon: Pokemon) {
        if !fav.isPokemonFavorite(pokemon) {
            fav.addFavoritePokemon(pokemon)
        } else {
            _ = fav.removeFavoritePokemon(pokemon)
        }
    }
    
    func didTapTeamButton(for pokemon: Pokemon) {
        if !team.isPokemonOnTeam(pokemon) {
            _ = team.addTeamPokemon(pokemon)
        } else {
            _ = team.removeTeamPokemon(pokemon)
        }
        applyTeamSnapshot()
        
    }
    
    
    @IBOutlet weak var teamTableView: UITableView!
    var team = MyTeamController.shared
    var fav = FavoriteController.shared
    var testCell: [String] = ["Test"]
    typealias myTeamDiffableDataSource = UITableViewDiffableDataSource<Int, Pokemon>
    var myTeamdataSource: myTeamDiffableDataSource!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureDataSource()
        applyTeamSnapshot()
        teamTableView.reloadData()
    }

      override func viewDidLoad() {
          super.viewDidLoad()
          
          teamTableView.dataSource = self
          teamTableView.delegate = self
          teamTableView.register(UINib(nibName: "MyTeamTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTeam")
             
          configureDataSource()
          applyTeamSnapshot()
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return MyTeamController.shared.teamPokemon.count
      }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTeam", for: indexPath) as! MyTeamTableViewCell
        let pokemon = MyTeamController.shared.teamPokemon[indexPath.row]

        cell.pokemonNameLabel.text = pokemon.name
        cell.pokemonTypeLabel.text = pokemon.types.map { $0.type.name }.joined(separator: ", ")
        cell.pokemonNOLabel.text = "No. \(pokemon.id)"
        cell.pokemonImageView.load(url: pokemon.sprites.front_default) 
        
        return cell
        
    }
    
      func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
              let success = MyTeamController.shared.removeTeamPokemon(MyTeamController.shared.teamPokemon[indexPath.row])
              if success {
                  tableView.deleteRows(at: [indexPath], with: .fade)
              }
          }
      }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            
            let pokemonToDelete = self.team.teamPokemon[indexPath.row]
            
            let success = self.team.removeTeamPokemon(pokemonToDelete)
            if success {
                var currentSnapshot = self.myTeamdataSource.snapshot()
                currentSnapshot.deleteItems([pokemonToDelete])
                self.myTeamdataSource.apply(currentSnapshot, animatingDifferences: true)
            }
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toTeamDetail", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBSegueAction func toTeamDetailSegue(_ coder: NSCoder) -> TeamDetailViewController? {
        return TeamDetailViewController(coder: coder)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTeamDetail" {
            if let detailVC = segue.destination as? TeamDetailViewController,
               let indexPath = sender as? IndexPath {
                let pokemon = team.teamPokemon[indexPath.row]
                detailVC.pokemon = pokemon
                print("Segue to detail with pokemon: \(pokemon.name)")
            } else {
                print("Failed to initialize detail view controller or index path.")
            }
        }
    }
    
    
    func configureDataSource() {
        myTeamdataSource = myTeamDiffableDataSource(tableView: teamTableView) { tableView, indexPath, pokemon in
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyTeam", for: indexPath) as! MyTeamTableViewCell
            cell.update(with: pokemon)
            cell.delegate = self
            return cell
        }
    }
    
    func applyTeamSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Pokemon>()
        snapshot.appendSections([0])
        snapshot.appendItems(team.teamPokemon, toSection: 0)
        myTeamdataSource.apply(snapshot, animatingDifferences: true)
    }

  }
