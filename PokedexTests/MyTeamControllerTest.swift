//
//  MyTeamControllerTest.swift
//  PokedexTests
//
//  Created by Tyler May on 5/15/24.
//

import XCTest
@testable import Pokedex

final class MyTeamControllerTest: XCTestCase {
    var controller: MyTeamController!
    
    override func setUp() {
        super.setUp()
        controller = MyTeamController.shared
        controller.teamPokemon = []
    }
    
    func testAddTeamPokemon() {
        let pokemon = Pokemon(name: "bulbasaur", types: [], sprites: PokemonSprites.testSprites, id: 1, stats: [], moves: [])
        
        XCTAssertEqual(controller.teamPokemon.count, 0)
        
        controller.addTeamPokemon(pokemon)
        
        XCTAssertEqual(controller.teamPokemon.count, 1)
        XCTAssertTrue(controller.isPokemonOnTeam(pokemon))
    }
    
    func testRemoveTeamPokemon() {
        let pokemon = Pokemon(name: "bulbasaur", types: [], sprites: PokemonSprites.testSprites, id: 1, stats: [], moves: [])
        
        controller.addTeamPokemon(pokemon)
        
        XCTAssertEqual(controller.teamPokemon.count, 1)
        
        let removed = controller.removeTeamPokemon(pokemon)
        
        XCTAssertTrue(removed)
        XCTAssertEqual(controller.teamPokemon.count, 0)
        XCTAssertFalse(controller.isPokemonOnTeam(pokemon))
    }
    
    func testIsPokemonOnTeam() {
        let pokemon1 = Pokemon(name: "bulbasaur", types: [], sprites: PokemonSprites.testSprites, id: 1, stats: [], moves: [])
        let pokemon2 = Pokemon(name: "charmander", types: [], sprites: PokemonSprites.testSprites, id: 4, stats: [], moves: [])
        
        controller.addTeamPokemon(pokemon1)
        
        XCTAssertTrue(controller.isPokemonOnTeam(pokemon1))
        XCTAssertFalse(controller.isPokemonOnTeam(pokemon2))
    }

}
