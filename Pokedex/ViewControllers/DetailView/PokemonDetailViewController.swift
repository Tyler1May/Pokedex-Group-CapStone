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
    @IBOutlet var movesButton: UIButton!
    @IBOutlet var pokemonImage: UIImageView!
    
    var pokemon: Pokemon?
    var evo: PokemonEvolutionContainer?
    var species: PokemonSpeciesContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon?.name.capitalized
        numberLabel.text = "No. \(pokemon?.id ?? 0)"
        if let imageURL = pokemon?.sprites.front_default {
            pokemonImage.load(url: imageURL)
        }
        
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
        
        // Set up pokemonImage constraints
        pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokemonImage.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 10),
            pokemonImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Set up nameLabel constraints
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Set up movesButton constraints
        movesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movesButton.widthAnchor.constraint(equalToConstant: 200),
            movesButton.heightAnchor.constraint(equalToConstant: 50),
            movesButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            movesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Create a scrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: movesButton.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
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
        
        // Add PokemonTypeView, PokemonStatusChartView, and PokemonImageView to the contentView
        let types = pokemon?.types ?? []
        let pokemonTypeView = UIHostingController(rootView: PokemonTypesView(typesContainer: types))
        addChild(pokemonTypeView)
        contentView.addSubview(pokemonTypeView.view)
        pokemonTypeView.didMove(toParent: self)
        
        let stats = pokemon?.stats ?? []
        let pokemonStatChartView = UIHostingController(rootView: PokemonStatusChart(stats: stats))
        addChild(pokemonStatChartView)
        contentView.addSubview(pokemonStatChartView.view)
        pokemonStatChartView.didMove(toParent: self)
        
        // Create PokemonImageView
        let evo = self.evo
        let pokemonImageView = UIHostingController(rootView: PokemonImageView(evo: evo))
        addChild(pokemonImageView)
        contentView.addSubview(pokemonImageView.view)
        pokemonImageView.didMove(toParent: self)
        
        // Set up constraints for PokemonTypeView and PokemonStatusChartView within contentView
        pokemonTypeView.view.translatesAutoresizingMaskIntoConstraints = false
        pokemonStatChartView.view.translatesAutoresizingMaskIntoConstraints = false
        pokemonImageView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokemonTypeView.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonTypeView.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            pokemonTypeView.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            pokemonStatChartView.view.topAnchor.constraint(equalTo: pokemonTypeView.view.bottomAnchor, constant: 10),
            pokemonStatChartView.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            pokemonStatChartView.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            /*pokemonStatChartView.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),*/ // last element, constrain to bottom of contentView
            
            pokemonImageView.view.topAnchor.constraint(equalTo: pokemonStatChartView.view.bottomAnchor, constant: 80),
            pokemonImageView.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            pokemonImageView.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            pokemonImageView.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
}
