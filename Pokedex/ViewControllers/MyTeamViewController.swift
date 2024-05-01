//
//  MyTeamViewController.swift
//  Pokedex
//
//  Created by Tyler May on 4/16/24.
//

import UIKit

class MyTeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var teamTableView: UITableView!
    var team = Team(pokemons: [])
    var testCell: [String] = ["Test"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        teamTableView.dataSource = self
        teamTableView.delegate = self
        teamTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyTeam")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team.pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let pokemon = team.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            team.removePokemon(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
}
