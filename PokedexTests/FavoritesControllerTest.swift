//
//  FavoritesControllerTest.swift
//  PokedexTests
//
//  Created by Tyler May on 5/14/24.
//

import XCTest
@testable import Pokedex

final class FavoritesControllerTest: XCTestCase {
    var controller: FavoriteController!
        
    override func setUp() {
        super.setUp()
        controller = FavoriteController.shared
        controller.favPokemon = [] // Ensure favPokemon array is empty before each test
    }
    
    func testAddFavoritePokemon() {
        let pokemon = Pokemon(name: "Pikachu", types: [], sprites: PokemonSprites.testSprites, id: 25, stats: [], moves: [])
            
        XCTAssertEqual(controller.favPokemon.count, 0)
            
        controller.addFavoritePokemon(pokemon)
            
        XCTAssertEqual(controller.favPokemon.count, 1)
        XCTAssertTrue(controller.isPokemonFavorite(pokemon))
    }
        
    func testRemoveFavoritePokemon() {
        let pokemon = Pokemon(name: "Pikachu", types: [], sprites: PokemonSprites.testSprites, id: 25, stats: [], moves: [])
            
        controller.addFavoritePokemon(pokemon)
            
        XCTAssertEqual(controller.favPokemon.count, 1)
            
        let removed = controller.removeFavoritePokemon(pokemon)
            
        XCTAssertTrue(removed)
        XCTAssertEqual(controller.favPokemon.count, 0)
        XCTAssertFalse(controller.isPokemonFavorite(pokemon))
    }
        
    func testIsPokemonFavorite() {
        let pokemon1 = Pokemon(name: "Pikachu", types: [], sprites: PokemonSprites.testSprites, id: 25, stats: [], moves: [])
        let pokemon2 = Pokemon(name: "Charmander", types: [], sprites: PokemonSprites.testSprites, id: 4, stats: [], moves: [])
            
        controller.addFavoritePokemon(pokemon1)
            
        XCTAssertTrue(controller.isPokemonFavorite(pokemon1))
        XCTAssertFalse(controller.isPokemonFavorite(pokemon2))
    }

}
