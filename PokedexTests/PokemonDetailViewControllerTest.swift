//
//  PokemonDetailViewControllerTest.swift
//  PokedexTests
//
//  Created by Tyler May on 5/14/24.
//

import XCTest
@testable import Pokedex

final class PokemonDetailViewControllerTest: XCTestCase {
    var sut: PokemonDetailViewController!

        override func setUpWithError() throws {
            let storyboard = UIStoryboard(name: "PokemonDetailView", bundle: nil)
            sut = storyboard.instantiateViewController(withIdentifier: "pokemonDetailView") as? PokemonDetailViewController
            sut.loadViewIfNeeded()
        }

        override func tearDownWithError() throws {
            sut = nil
        }

        func testViewDidLoad() {
            XCTAssertNotNil(sut.nameLabel)
            XCTAssertNotNil(sut.numberLabel)
            XCTAssertNotNil(sut.movesButton)
            XCTAssertNotNil(sut.pokemonFrontImage)
            XCTAssertNotNil(sut.pokemonBackImage)
            XCTAssertNotNil(sut.shinyButton)

        }

        func testShinySwitchChanged() {
            let mockPokemon = Pokemon(name: "bulbasaur", types: [], sprites: PokemonSprites.testSprites, id: 1, stats: [], moves: [])
            sut.pokemon = mockPokemon

            XCTAssertFalse(sut.showShiny)
            XCTAssertEqual(sut.pokemonFrontImage.image, UIImage(named: "front_shiny"))
            XCTAssertEqual(sut.pokemonBackImage.image, UIImage(named: "back_shiny"))

            sut.showShiny = true
            XCTAssertTrue(sut.showShiny)
            XCTAssertEqual(sut.pokemonFrontImage.image, UIImage(named: "front_default"))
            XCTAssertEqual(sut.pokemonBackImage.image, UIImage(named: "back_default"))
            
            sut.showShiny = false
            XCTAssertFalse(sut.showShiny)
            XCTAssertEqual(sut.pokemonFrontImage.image, UIImage(named: "front_default"))
            XCTAssertEqual(sut.pokemonBackImage.image, UIImage(named: "back_default"))
        }
}
