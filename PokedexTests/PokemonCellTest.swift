//
//  PokemonCellTest.swift
//  PokedexTests
//
//  Created by Tyler May on 5/15/24.
//

import XCTest
@testable import Pokedex

final class PokemonCellTests: XCTestCase {
    
    var cell: PokemonCell!
    var mockDelegate: MockUpdateCellDelegate!
    var pokemon: Pokemon!
    
    override func setUp() {
        super.setUp()
        // Load PokemonCell from nib or storyboard
        let nib = UINib(nibName: "PokemonCell", bundle: nil)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        cell = objects.first as? PokemonCell
        
        mockDelegate = MockUpdateCellDelegate()
        cell.delegate = mockDelegate
        
        // Create a sample Pokemon
        pokemon = Pokemon(name: "bulbasaur", types: [], sprites: PokemonSprites.testSprites, id: 1, stats: [], moves: [])
    }
    
    func testUpdateMethod() {
        cell.update(with: pokemon)
        
        XCTAssertEqual(cell.pokemonName.text, "Bulbasaur")
        XCTAssertEqual(cell.pokemonNumber.text, "No. 1")
        XCTAssertEqual(cell.pokemonType.text, "")
    }
    
    func testAddToTeamButtonTapped() {
        cell.update(with: pokemon)
        
        cell.addToTeamButtonTapped(cell.myTeamButton!)
        
        XCTAssertTrue(mockDelegate.didTapTeamButtonCalled)
        XCTAssertEqual(mockDelegate.pokemon, pokemon)
    }
    
    func testFavoriteButtonTapped() {
        cell.update(with: pokemon)
        
        cell.favoriteButton(cell.likeButton!)
        
        XCTAssertTrue(mockDelegate.didTapLikeButtonCalled)
        XCTAssertEqual(mockDelegate.pokemon, pokemon)
    }
    
    func testUpdateLikeButton() {
        FavoriteController.shared.favPokemon = [pokemon]
        
        cell.update(with: pokemon)
        
        XCTAssertEqual(cell.likeButton.image(for: .normal), UIImage(systemName: "star.fill"))
        XCTAssertEqual(cell.likeButton.tintColor, .systemYellow)
    }
    
    func testUpdateTeamButton() {
        MyTeamController.shared.teamPokemon = [pokemon]
        
        cell.update(with: pokemon)
        
        XCTAssertEqual(cell.myTeamButton.image(for: .normal), UIImage(named: "pokeball.fill"))
    }
}

class MockUpdateCellDelegate: UpdateCellDelegate {
    var didTapLikeButtonCalled = false
    var didTapTeamButtonCalled = false
    var pokemon: Pokemon?
    
    func didTapLikeButton(for pokemon: Pokemon) {
        didTapLikeButtonCalled = true
        self.pokemon = pokemon
    }
    
    func didTapTeamButton(for pokemon: Pokemon) {
        didTapTeamButtonCalled = true
        self.pokemon = pokemon
    }
}
