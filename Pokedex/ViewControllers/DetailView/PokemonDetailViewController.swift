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
    var evo: PokemonEvolutionContainer?
    
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
        
//        let imageViewContentView = UIView()
        
        // Create PokemonImageView
        let evo = self.evo
        let pokemonImageView = UIHostingController(rootView: PokemonImageView(evo: evo))
        addChild(pokemonImageView)
        view.addSubview(pokemonImageView.view)
        pokemonImageView.didMove(toParent: self)
        
        // Set up constraints for PokemonImageView
        pokemonImageView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokemonImageView.view.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 60),
            pokemonImageView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonImageView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Set up nameLabel constraints
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: pokemonImageView.view.bottomAnchor, constant: 60),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Create a scrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Create a contentView
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // ensures the contentView doesn't scroll horizontally
        ])
        
        // Add PokemonTypeView and PokemonStatusChartView to the contentView
        let types = pokemon?.types ?? []
        let pokemonTypeView = UIHostingController(rootView: PokemonTypesView(types: types))
        addChild(pokemonTypeView)
        contentView.addSubview(pokemonTypeView.view)
        pokemonTypeView.didMove(toParent: self)
        
        let stats = pokemon?.stats ?? []
        let pokemonStatChartView = UIHostingController(rootView: PokemonStatusChart(stats: stats))
        addChild(pokemonStatChartView)
        contentView.addSubview(pokemonStatChartView.view)
        pokemonStatChartView.didMove(toParent: self)
        
        // Set up constraints for PokemonTypeView and PokemonStatusChartView within contentView
        pokemonTypeView.view.translatesAutoresizingMaskIntoConstraints = false
        pokemonStatChartView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokemonTypeView.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonTypeView.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            pokemonTypeView.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            pokemonStatChartView.view.topAnchor.constraint(equalTo: pokemonTypeView.view.bottomAnchor, constant: 10),
            pokemonStatChartView.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            pokemonStatChartView.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            pokemonStatChartView.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor) // last element, constrain to bottom of contentView
        ])
    }
    
}
