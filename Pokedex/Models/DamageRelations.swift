//
//  DamageRelations.swift
//  Pokedex
//
//  Created by shark boy on 4/19/24.
//

import Foundation

// refer to this website for type understanding https://pokemondb.net/type

/*
0 No effect (0%) == noDamageFrom, noDamageTo
½ Not very effective (50%) == halfDamageFrom, halfDamageTo
  Normal (100%) // no UI needed
2 Super-effective (200%) == doubleDamageFrom, doubleDamageTo
*/
 



struct DamageRelations: Codable {
    let doubleDamageFrom: [DamageType?]
    let doubleDamageTo: [DamageType?]
    let halfDamageFrom: [DamageType?]
    let halfDamageTo: [DamageType?]
    let noDamageFrom: [DamageType?]
    let noDamageTo: [DamageType?]

    enum CodingKeys: String, CodingKey {
        case doubleDamageFrom = "double_damage_from"
        case doubleDamageTo = "double_damage_to"
        case halfDamageFrom = "half_damage_from"
        case halfDamageTo = "half_damage_to"
        case noDamageFrom = "no_damage_from"
        case noDamageTo = "no_damage_to"
    }
}
struct DamageType: Codable {
    let name: String
}

struct DamageRelationsContainer: Codable {
    let damageRelations: DamageRelations
    
    enum CodingKeys: String, CodingKey {
        case damageRelations = "damage_relations"
    }
}
    
