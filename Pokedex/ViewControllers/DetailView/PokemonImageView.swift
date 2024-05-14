//
//  PokemonImageView.swift
//  Pokedex
//
//  Created by Tyler May on 4/19/24.
//

import SwiftUI

struct PokemonImageView: View {
    var evo: PokemonEvolutionContainer?
    @State var evoPokemon: [Pokemon] = []
    
    var body: some View {
        ScrollView(.horizontal) {
            VStack(alignment: .leading) {
                Text("Evolution:")
                    .font(.title)
                HStack(spacing: 10) {
                    ForEach(evoPokemon, id: \.id) { pokemon in
                        EvolutionView(pokemon: pokemon)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        .shadow(radius: 10)
        .onAppear {
            traverseChain(evo?.chain)
        }
    }
    
    func traverseChain(_ chain: EvolutionChain?) {
        guard let chain = chain else { return }
        
        let speciesName = chain.species.name
        
            Task {
                do {
                    if let pokemon = try await PokemonController.getSpecificPokemon(pokemonName: speciesName) {
                        let species = try await PokemonController.getPokemonSpecies(pokemon.id)
                            if species?.evolvesFrom == nil {
                                evoPokemon.insert(pokemon, at: 0)
                            } else if chain.evolvesTo.isEmpty {
                                evoPokemon.append(pokemon)
                            } else if !evoPokemon.isEmpty {
                                evoPokemon.insert(pokemon, at: 1)
                            } else {
                                evoPokemon.append(pokemon)
                            }
                    }
                } catch {
                    print("Error fetching pokemon info: \(error.localizedDescription)")
                }
            }
            
            for evolution in chain.evolvesTo {
                traverseChain(evolution)
            }
        }
}

struct EvolutionView: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                Circle()
                    .stroke(Color.black , lineWidth: 2) // Customize the color and lineWidth as per your preference
                    .frame(width: 210, height: 105)// Adjust the size of the circle as needed
                    .padding(.top, 5)
                AsyncImage(url: URL(string: "\(pokemon.sprites.front_default)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 100)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
            }
            .padding(.bottom, 10)
            Text(pokemon.name.capitalized)
                .font(.title)
        }
    }
}


#Preview {
    PokemonImageView()
}
