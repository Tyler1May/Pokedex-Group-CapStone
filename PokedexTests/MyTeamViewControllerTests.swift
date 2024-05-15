//
//  MyTeamViewControllerTests.swift
//  PokedexTests
//
//  Created by Tyler May on 5/15/24.
//

import XCTest
@testable import Pokedex

class MyTeamViewControllerTests: XCTestCase {
    
    var sut: MyTeamViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "MyTeamView", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "MyTeamViewController") as? MyTeamViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testViewDidLoad_Always_SetsTableViewDataSourceAndDelegate() {
        sut.viewDidLoad()

        XCTAssertNotNil(sut.teamTableView.dataSource)
        XCTAssertNotNil(sut.teamTableView.delegate)
        XCTAssertTrue(sut.teamTableView.delegate is MyTeamViewController)
    }
    
    func testApplyTeamSnapshot_Always_AppliesCorrectSnapshot() {
        let pokemon = Pokemon(name: "bulbasaur", types: [], sprites: PokemonSprites.testSprites, id: 1, stats: [], moves: [])
        sut.team.teamPokemon = [pokemon]
        
        sut.applyTeamSnapshot()
        
        XCTAssertEqual(sut.myTeamdataSource.tableView(sut.teamTableView, numberOfRowsInSection: 0), 1)
        XCTAssertEqual(sut.myTeamdataSource.itemIdentifier(for: IndexPath(row: 0, section: 0))?.id, 1)
    }
    
    func testDidTapLikeButton_WhenPokemonIsNotFavorite_AddsPokemonToFavorites() {
        let pokemon = Pokemon(name: "bulbasaur", types: [], sprites: PokemonSprites.testSprites, id: 1, stats: [], moves: [])
        sut.didTapLikeButton(for: pokemon)
        
        XCTAssertTrue(sut.fav.isPokemonFavorite(pokemon))
    }
    
    func testDidTapLikeButton_WhenPokemonIsFavorite_RemovesPokemonFromFavorites() {

        let pokemon = Pokemon(name: "bulbasaur", types: [], sprites: PokemonSprites.testSprites, id: 1, stats: [], moves: [])
        sut.fav.addFavoritePokemon(pokemon)
        
        sut.didTapLikeButton(for: pokemon)
        
        XCTAssertFalse(sut.fav.isPokemonFavorite(pokemon))
    }
    
}
