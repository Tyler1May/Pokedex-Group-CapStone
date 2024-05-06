//
//  PokemonTypesView.swift
//  Pokedex
//
//  Created by Tyler May on 4/19/24.
//

import SwiftUI

struct PokemonTypesView: View {
    var typesContainer: [PokemonTypeContainer]
    @State var damageContainer: DamageRelationsContainer?
    @State var damageRelationsDict = [String: DamageRelations]()
    @State var weaknesses = [String]()
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                // Types
                VStack(alignment: .leading, spacing: 10) {
                    Text("Types:")
                        .font(.title)
                    gridForTypes()
                        .frame(width: 285)
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(20)
                .padding()
                .shadow(radius: 10)
                
                // Weaknesses
                VStack(alignment: .leading, spacing: 10) {
                    Text("Weaknesses:")
                        .font(.title)
                    gridForWeaknesses()
                        .frame(width: 285)
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(20)
                .padding()
                .shadow(radius: 10)
                
                // Strengths
                VStack(alignment: .leading, spacing: 10) {
                    Text("Strengths:")
                        .font(.title)
                    gridForTypes()
                        .frame(width: 285)
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(20)
                .padding()
                .shadow(radius: 10)
            }
        }
        .onAppear {
            fetchDamageRelations()
        }
    }
    
    @ViewBuilder
    private func gridForTypes() -> some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
        
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(typesContainer, id: \.type.name) { typeContainer in
                Text(typeContainer.type.name.capitalized)
                    .font(.subheadline)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                    .background(Color(typeColor(for: typeContainer.type.name)))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        
    }
    
    @ViewBuilder
    private func gridForWeaknesses() -> some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
        
        if let doubleDamageFrom = damageContainer?.damageRelations.doubleDamageFrom {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(doubleDamageFrom.compactMap { $0 }, id: \.name) { damageType in
                    Text(damageType.name.capitalized)
                        .font(.subheadline)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                        .background(Color(typeColor(for: damageType.name)))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            
        } else {
            Text("No weaknesses found")
                .foregroundStyle(.gray)
        }
    }
    
    func fetchDamageRelations() {
        Task {
            do {
                for type in typesContainer {
                    if let damageRelations = try await PokemonController.getPokemonDamageRelatons(type.type.name) {
                        damageRelationsDict[type.type.name] = damageRelations.damageRelations
                    }
                }
                
                var doubleDamageFromTypes: [String] = []
                var halfDamageFromTypes: [String] = []
                
                
                weaknesses = doubleDamageTypes.filter { !halfDamageFromTypes.contains($0) }
                
            } catch {
                print("Error fetching damage relations: \(error.localizedDescription) ")
            }
        }
    }
    
    func typeColor(for name: String) -> UIColor {
        switch name {
        case "normal":
            return UIColor.normal
        case "bug":
            return UIColor.bug
        case "dragon":
            return UIColor.dragon
        case "fairy":
            return UIColor.fairy
        case "fire":
            return UIColor.fire
        case "ghost":
            return UIColor.ghost
        case "ground":
            return UIColor.ground
        case "psychic":
            return  UIColor.psychic
        case "steel" :
            return UIColor.steel
        case "dark" :
            return UIColor.dark
        case "electric" :
            return UIColor.electric
        case "fighting" :
            return UIColor.fighting
        case "flying" :
            return UIColor.flying
        case "grass" :
            return UIColor.grass
        case "ice" :
            return UIColor.ice
        case "poison" :
            return UIColor.poison
        case "rock" :
            return UIColor.rock
        case "water" :
            return UIColor.water
        default:
            return .gray
        }
    }
    
}

#Preview {
    PokemonTypesView(typesContainer: [
        PokemonTypeContainer(slot: 1, type: .init(name: "electric")),
        PokemonTypeContainer(slot: 1, type: .init(name: "fire")),
        PokemonTypeContainer(slot: 1, type: .init(name: "water")),
        PokemonTypeContainer(slot: 1, type: .init(name: "rock")),
        PokemonTypeContainer(slot: 1, type: .init(name: "fighting")),
        PokemonTypeContainer(slot: 1, type: .init(name: "psychic")),
        PokemonTypeContainer(slot: 1, type: .init(name: "fairy")),
        PokemonTypeContainer(slot: 1, type: .init(name: "grass")),
        PokemonTypeContainer(slot: 1, type: .init(name: "bug"))
    ])
}
