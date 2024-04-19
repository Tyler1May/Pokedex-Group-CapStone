//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Tyler May on 4/19/24.
//

import UIKit
import SwiftUI

class PokemonDetailViewController: UIViewController {
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon?.name.capitalized
        numberLabel.text = "No. \(pokemon?.id ?? 0)"
        
        // Set up numberLabel constraints
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            numberLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        // Set up genderLabel constraints
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            genderLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        // Create PokemonImageView
        let images = (pokemon?.sprites)!
        let pokemonImageView = UIHostingController(rootView: PokemonImageView(image: images))
        addChild(pokemonImageView)
        view.addSubview(pokemonImageView.view)
        pokemonImageView.didMove(toParent: self)
        
        // Set up constraints for PokemonImageView
        pokemonImageView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokemonImageView.view.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 20),
            pokemonImageView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonImageView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Set up nameLabel constraints
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: pokemonImageView.view.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Create PokemonTypeView
        let types = pokemon?.types ?? []
        let pokemonTypeView = UIHostingController(rootView: PokemonTypesView(types: types))
        addChild(pokemonTypeView)
        view.addSubview(pokemonTypeView.view)
        pokemonTypeView.didMove(toParent: self)
        
        // Set up constraints for PokemonTypeView
        pokemonTypeView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokemonTypeView.view.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            pokemonTypeView.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            pokemonTypeView.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
        
        // Create PokemonStatusChartView
        let stats = pokemon?.stats ?? []
        let pokemonStatChartView = UIHostingController(rootView: PokemonStatusChart(stats: stats))
        addChild(pokemonStatChartView)
        view.addSubview(pokemonStatChartView.view)
        pokemonStatChartView.didMove(toParent: self)
        
        // Set up constraints for PokemonStatusChartView
        pokemonStatChartView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokemonStatChartView.view.topAnchor.constraint(equalTo: pokemonTypeView.view.bottomAnchor, constant: 20),
            pokemonStatChartView.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            pokemonStatChartView.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
    }

}
