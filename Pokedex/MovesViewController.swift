//
//  MovesViewController.swift
//  Pokedex
//
//  Created by Tyler May on 5/7/24.
//

import UIKit

class MovesViewController: UIViewController {
    
    @IBOutlet var movesTableView: UITableView!
    @IBOutlet var moveNameLabel: UILabel!
    @IBOutlet var accuracyLabel: UILabel!
    @IBOutlet var damageClassLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    
    
    var moves: [PokemonMoveContainer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableViewCell()

    }
    
    func configureTableViewCell() {
        movesTableView.register(UINib(nibName: "PokemonMovesCell", bundle: nil), forCellReuseIdentifier: "MovesCell")
        movesTableView.delegate = self
        movesTableView.dataSource = self
    }
    

}

extension MovesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovesCell", for: indexPath) as! PokemonMovesCell
        
        let moveContainer = moves[indexPath.row]
        cell.update(with: moveContainer)
        
        return cell
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMove = moves[indexPath.row]
        
        moveNameLabel.text = selectedMove.move.name?.capitalized ?? "N/A"
//        accuracyLabel.text = "Accuracy: \()
//        damageClassLabel.text = "Damage Class: \()"
//        typeLabel.text = "Type: \()"
        
    }


}
