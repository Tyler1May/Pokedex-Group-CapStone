//
//  SearchViewControllerTest.swift
//  PokedexTests
//
//  Created by Tyler May on 5/15/24.
//

import XCTest
@testable import Pokedex

class SearchViewControllerTests: XCTestCase {
    
    var sut: SearchViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "SearchView", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testViewDidLoad_Always_ConfiguresTableViewAndDataSource() {
        sut.viewDidLoad()

        XCTAssertNotNil(sut.searchTableView.dataSource)
        XCTAssertNotNil(sut.searchTableView.delegate)
        XCTAssertTrue(sut.searchTableView.delegate is SearchViewController)
    }
    
    
    
    func testDidTapLikeButton_WhenPokemonIsNotFavorite_TogglesFavoriteStatus() {
        let pokemon = Pokemon(name: "bulbasaur", types: [], sprites: PokemonSprites.testSprites, id: 1, stats: [], moves: [])
        sut.fav.favPokemon = []
        
        sut.didTapLikeButton(for: pokemon)
        
        XCTAssertTrue(sut.fav.isPokemonFavorite(pokemon))
        
        sut.didTapLikeButton(for: pokemon)
        
        XCTAssertFalse(sut.fav.isPokemonFavorite(pokemon))
    }
    
}
