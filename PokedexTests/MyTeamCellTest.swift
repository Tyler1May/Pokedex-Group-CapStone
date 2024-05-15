//
//  MyTeamCellTest.swift
//  PokedexTests
//
//  Created by Tyler May on 5/15/24.
//

import XCTest
@testable import Pokedex

final class MyTeamTableViewCellTests: XCTestCase {

    var cell: MyTeamTableViewCell!
    var mockDelegate: MockUpdateTeamCellDelegate!
    var pokemon: Pokemon!
    
    override func setUp() {
        super.setUp()
        
        // Load MyTeamTableViewCell from nib
        let nib = UINib(nibName: "MyTeamTableViewCell", bundle: nil)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        cell = objects.first as? MyTeamTableViewCell
        
        // Initialize mock delegate and team controller
        mockDelegate = MockUpdateTeamCellDelegate()
        cell.delegate = mockDelegate
        
        // Create a sample Pokemon
        pokemon = Pokemon(name: "bulbasaur", types: [], sprites: PokemonSprites.testSprites, id: 1, stats: [], moves: [])
    }
    
    func testUpdateMethod() {
        cell.update(with: pokemon)
        

        XCTAssertEqual(cell.pokemonNameLabel.text, "Bulbasaur")
        XCTAssertEqual(cell.pokemonNOLabel.text, "No. 1")
        XCTAssertEqual(cell.pokemonTypeLabel.text, "")
    }
   
}

class MockUpdateTeamCellDelegate: UpdateCellDelegate {
    var didTapLikeButtonCalled = false
    var didTapTeamButtonCalled = false
    var pokemonPassed: Pokemon?
    
    func didTapLikeButton(for pokemon: Pokedex.Pokemon) {
        didTapLikeButtonCalled = false
        pokemonPassed = pokemon
    }
    
    func didTapTeamButton(for pokemon: Pokedex.Pokemon) {
        didTapTeamButtonCalled = true
        pokemonPassed = pokemon
    }
}

