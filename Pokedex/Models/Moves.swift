//
//  Moves.swift
//  Pokedex
//
//  Created by shark boy on 4/26/24.
//

import Foundation

struct PokemonMovesContainer: Codable {
    let move: Move
    let details: [MoveDetails]
    
    enum CodingKeys: String, CodingKey {
        case move
        case details = "version_group_details"
    }
}

struct Move: Codable {
    let name: String?
    let url: String? 
}

extension Move {
    static var testMove: Move {
        Move(name: "razor-wind", url: "https://pokeapi.co/api/v2/move/13/")
    }
}

struct MoveDetails: Codable {
    let levelLearned: Int?
    let learnMethod: LearnMethod?
    
    enum CodingKeys: String, CodingKey {
        case levelLearned = "level_learned_at"
        case learnMethod = "move_learn_method"
    }
}

extension MoveDetails {
    static var testMoveDetails: MoveDetails {
        MoveDetails(levelLearned: 0, learnMethod: LearnMethod.testLearnMethod)
    }
}

struct LearnMethod: Codable {
    let method: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case method = "name"
        case url
        
    }
}

extension LearnMethod {
    static var testLearnMethod: LearnMethod {
        LearnMethod(method: "egg", url: "https://pokeapi.co/api/v2/move-learn-method/2/")
    }
}

struct PokemonMoveInfo: Codable {
    let accuracy: Int?
    let damageClass: DamageClass?
    let type: MoveType?
    let effect: [EffectEntry]?
    let power: Int?
    let pp: Int?
    let priority: Int?
    
    enum CodingKeys: String, CodingKey {
        case accuracy
        case damageClass = "damage_class"
        case type
        case effect = "effect_entries"
        case power
        case pp
        case priority
    }
}

struct EffectEntry: Codable {
    let effect: String
    let shortEffect: String
    
    enum CodingKeys: String, CodingKey {
        case effect
        case shortEffect = "short_effect"
    }
}

struct DamageClass: Codable {
    let name: String
    let url: URL
}

struct MoveType: Codable {
    let name: String
    let url: URL
}
