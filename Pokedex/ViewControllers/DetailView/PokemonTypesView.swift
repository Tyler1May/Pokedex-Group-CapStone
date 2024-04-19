//
//  PokemonTypesView.swift
//  Pokedex
//
//  Created by Tyler May on 4/19/24.
//

import SwiftUI

struct PokemonTypesView: View {
    var types: [PokemonTypeContainer]

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                // Types
                VStack(alignment: .leading, spacing: 10) {
                    Text("Types:")
                        .font(.title)
                    gridForTypes()
                        .frame(width: 325)
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
                    gridForTypes()
                        .frame(width: 325)
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
                        .frame(width: 325)
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(20)
                .padding()
                .shadow(radius: 10)
            }
        }
    }
    
    @ViewBuilder
    private func gridForTypes() -> some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
        
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(types, id: \.type.name) { typeContainer in
                Text(typeContainer.type.name)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
    
}
#Preview {
    PokemonTypesView(types: [
        PokemonTypeContainer(slot: 1, type: .init(name: "Plant")),
        PokemonTypeContainer(slot: 1, type: .init(name: "Fire")),
        PokemonTypeContainer(slot: 1, type: .init(name: "Water")),
        PokemonTypeContainer(slot: 1, type: .init(name: "Earth")),
        PokemonTypeContainer(slot: 1, type: .init(name: "Big")),
        PokemonTypeContainer(slot: 1, type: .init(name: "huge")),
        PokemonTypeContainer(slot: 1, type: .init(name: "strong")),
        PokemonTypeContainer(slot: 1, type: .init(name: "poison")),
        PokemonTypeContainer(slot: 1, type: .init(name: "giant"))
    ])
}
