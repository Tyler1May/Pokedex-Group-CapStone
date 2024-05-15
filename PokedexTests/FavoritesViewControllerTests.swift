//
//  FavoritesViewControllerTests.swift
//  PokedexTests
//
//  Created by Tyler May on 5/15/24.
//

import XCTest
@testable import Pokedex // Import your app module here

final class FavoritesViewControllerTests: XCTestCase {
    
    var sut: FavoritesViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "FavoritesView", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "FavoritesView") as? FavoritesViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testViewDidLoad_Always_SetsTableViewDataSourceAndDelegate() {
        sut.viewDidLoad()

        XCTAssertNotNil(sut.favoriteTableView.dataSource)
        XCTAssertNotNil(sut.favoriteTableView.delegate)
        XCTAssertTrue(sut.favoriteTableView.delegate is FavoritesViewController)
    }
    
    func testApplySnapshot_Always_AppliesCorrectSnapshot() {
        let pokemon = Pokemon(name: "bulbasaur", types: [], sprites: PokemonSprites.testSprites, id: 1, stats: [], moves: [])
        sut.fav.favPokemon = [pokemon]
        
        sut.applySnapshot()
        
        XCTAssertEqual(sut.dataSource.tableView(sut.favoriteTableView, numberOfRowsInSection: 0), 1)
        XCTAssertEqual(sut.dataSource.itemIdentifier(for: IndexPath(row: 0, section: 0))?.id, 1)
    }
    
    
    func testDidTapTeamButton_WhenPokemonIsNotOnTeam_AddsPokemonToTeam() {
        let pokemon = Pokemon(name: "bulbasaur", types: [], sprites: PokemonSprites.testSprites, id: 1, stats: [], moves: [])
        
        sut.didTapTeamButton(for: pokemon)
        
        XCTAssertTrue(sut.team.isPokemonOnTeam(pokemon))
    }
    
    func testDidTapTeamButton_WhenPokemonIsOnTeam_RemovesPokemonFromTeam() {
        let pokemon = Pokemon(name: "bublasaur", types: [], sprites: PokemonSprites.testSprites, id: 1, stats: [], moves: [])
        sut.team.addTeamPokemon(pokemon)
        
        sut.didTapTeamButton(for: pokemon)
        
        XCTAssertFalse(sut.team.isPokemonOnTeam(pokemon))
    }
    
    func testDidTapLikeButton_WhenPokemonIsNotFavorite_TogglesFavoriteStatus() {
        // Given
        let pokemon = Pokemon(name: "bublasaur", types: [], sprites: PokemonSprites.testSprites, id: 1, stats: [], moves: [])
        sut.fav.favPokemon = []
        
        sut.didTapLikeButton(for: pokemon)

        XCTAssertTrue(sut.fav.isPokemonFavorite(pokemon))

        sut.didTapLikeButton(for: pokemon)
        
        XCTAssertFalse(sut.fav.isPokemonFavorite(pokemon))
    }
    
    
}
