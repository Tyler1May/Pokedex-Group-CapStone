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
    
    
    var moves: [PokemonMovesContainer] = []
    var moveDetail: PokemonMoveDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableViewCell()
        getMoveDetail(move: moves[0].move.url ?? "")
    
        movesTableView.reloadData()

    }
    
    func configureTableViewCell() {
        movesTableView.register(UINib(nibName: "PokemonMovesCell", bundle: nil), forCellReuseIdentifier: "MovesCell")
        movesTableView.delegate = self
        movesTableView.dataSource = self
    }
    
    func getMoveDetail(move: String) {
        Task {
            do {
                moveDetail = try await PokemonController.getMoveDetail(move)
                DispatchQueue.main.async {
                    self.moveNameLabel.text = self.moves[0].move.name?.capitalized
                    self.accuracyLabel.text = "Accuracy: \(self.moveDetail?.accuracy ?? 0)"
                    self.damageClassLabel.text = "Damage Class: \(self.moveDetail?.damageClass.name.capitalized ?? "")"
                    self.typeLabel.text = "Move Type: \(self.moveDetail?.type.name.capitalized ?? "")"
                }
            } catch {
                print("Error getting move detail: \(error.localizedDescription)")
            }
        }
        
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
        
        getMoveDetail(move: selectedMove.move.url ?? "")
    }


}
