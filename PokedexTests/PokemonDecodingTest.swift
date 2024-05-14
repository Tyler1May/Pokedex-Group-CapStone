//
//  PokemonDecodingTest.swift
//  PokedexTests
//
//  Created by Tyler May on 5/14/24.
//

import XCTest
@testable import Pokedex

final class PokemonDecodingTest: XCTestCase {
    func testPokemonDecoding() throws {
        // Given
        let bundle = Bundle(for: type(of: self))
        let json = bundle.url(forResource: "Pokemon", withExtension: "json")!
        
        // When
        let jsonData = try Data(contentsOf: json)
        let decoder = JSONDecoder()
        let pokemon = try decoder.decode(Pokemon.self, from: jsonData)
        
        // Then
        XCTAssertEqual(pokemon.name, "bulbasaur")
        XCTAssertEqual(pokemon.types.count, 2)
        XCTAssertEqual(pokemon.types[0].type.name, "grass")
        XCTAssertEqual(pokemon.types[1].type.name, "poison")
        XCTAssertEqual(pokemon.sprites.front_default.absoluteString, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        XCTAssertEqual(pokemon.sprites.back_default.absoluteString, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png")
        XCTAssertEqual(pokemon.sprites.front_shiny.absoluteString, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png")
        XCTAssertEqual(pokemon.sprites.back_shiny.absoluteString, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png")
        XCTAssertEqual(pokemon.id, 1)
        XCTAssertEqual(pokemon.stats.count, 6)
        XCTAssertEqual(pokemon.stats[0].baseStat, 45)
        XCTAssertEqual(pokemon.stats[0].stat.name, "hp")
        XCTAssertEqual(pokemon.moves.count, 86)
        XCTAssertEqual(pokemon.moves[0].move.name, "razor-wind")
    }
    
}
