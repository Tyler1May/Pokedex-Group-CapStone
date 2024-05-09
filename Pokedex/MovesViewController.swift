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
    @IBOutlet var levelLearnedLabel: UILabel!
    @IBOutlet var learnMethodLabel: UILabel!
    @IBOutlet var moveEffectLabel: UILabel!
    
    
    var moves: [PokemonMovesContainer] = []
    var moveDetail: PokemonMoveInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableViewCell()
//        configureFonts()
        getMoveDetail(move: moves[0].move.url ?? "", moveName: moves[0].move.name ?? "", selectedMove: moves[0].details)
    
        movesTableView.reloadData()

    }
    
    func configureTableViewCell() {
        movesTableView.register(UINib(nibName: "PokemonMovesCell", bundle: nil), forCellReuseIdentifier: "MovesCell")
        movesTableView.delegate = self
        movesTableView.dataSource = self
    }
    
//    func configureFonts() {
//        moveNameLabel.setPokemonFont(size: 20)
//        accuracyLabel.setPokemonFont(size: 10)
//        damageClassLabel.setPokemonFont(size: 10)
//        typeLabel.setPokemonFont(size: 15)
//        levelLearnedLabel.setPokemonFont(size: 10)
//        learnMethodLabel.setPokemonFont(size: 10)
//    }
    
    func getMoveDetail(move: String, moveName: String, selectedMove: [MoveDetails]) {
        Task {
            do {
                moveDetail = try await PokemonController.getMoveDetail(move)
                DispatchQueue.main.async {
                    self.moveNameLabel.text = moveName.capitalized
                    self.levelLearnedLabel.text = "Level Learned: \(selectedMove[0].levelLearned ?? 0)"
                    self.learnMethodLabel.text = "Method: \(selectedMove[0].learnMethod?.method.capitalized ?? "")"
                    self.accuracyLabel.text = "Accuracy: \(self.moveDetail?.accuracy ?? 0)"
                    self.damageClassLabel.text = "Damage Class: \(self.moveDetail?.damageClass?.name.capitalized ?? "")"
                    if let effect = self.moveDetail?.effect?[0].effect {
                        self.moveEffectLabel.text = "Move Effect: \n\(effect)"
                    }
                    self.typeLabel.text = "\(self.moveDetail?.type?.name.capitalized ?? "")"
                    self.typeLabel.layer.cornerRadius = 10
                    self.typeLabel.clipsToBounds = true
                    if let type = self.moveDetail?.type?.name {
                        self.typeLabel.backgroundColor = UIColor(named: type)
                        self.view.layer.sublayers?.forEach {
                            if $0 is CAGradientLayer {
                                $0.removeFromSuperlayer()
                            }
                        }
                        let gradientLayer = CAGradientLayer()
                        gradientLayer.frame = self.view.bounds
                        gradientLayer.colors = [UIColor(named: type)?.cgColor ?? UIColor.clear.cgColor, UIColor.white.cgColor]
                        gradientLayer.locations = [0.0, 0.5]
                        self.view.layer.insertSublayer(gradientLayer, at: 0)
                    }
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
        
        getMoveDetail(move: selectedMove.move.url ?? "", moveName: selectedMove.move.name ?? "", selectedMove: selectedMove.details)
        
        movesTableView.deselectRow(at: indexPath, animated: true)
    }


}
