//
//  EvolutionChainDecodingTest.swift
//  PokedexTests
//
//  Created by Tyler May on 5/15/24.
//

import XCTest
@testable import Pokedex

final class PokemonEvolutionDecodeTests: XCTestCase {
    
    func testDecoding() {
        let json = """
        {
            "chain": {
                "evolves_to": [
                    {
                        "evolves_to": [],
                        "species": {
                            "name": "ivysaur",
                            "url": "https://pokeapi.co/api/v2/pokemon-species/2/"
                        }
                    }
                ],
                "species": {
                    "name": "bulbasaur",
                    "url": "https://pokeapi.co/api/v2/pokemon-species/1/"
                }
            },
            "id": 1
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let decodedContainer: PokemonEvolutionContainer
        
        do {
            decodedContainer = try decoder.decode(PokemonEvolutionContainer.self, from: json)
        } catch {
            XCTFail("Decoding failed with error: \(error)")
            return
        }
        
        XCTAssertEqual(decodedContainer.id, 1)
        XCTAssertEqual(decodedContainer.chain.species.name, "bulbasaur")
        XCTAssertEqual(decodedContainer.chain.species.url, "https://pokeapi.co/api/v2/pokemon-species/1/")
        
        let firstEvolution = decodedContainer.chain.evolvesTo.first!!
        XCTAssertEqual(firstEvolution.species.name, "ivysaur")
        XCTAssertEqual(firstEvolution.species.url, "https://pokeapi.co/api/v2/pokemon-species/2/")
    }
}
