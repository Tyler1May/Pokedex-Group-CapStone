//
//  PokemonImageView.swift
//  Pokedex
//
//  Created by Tyler May on 4/19/24.
//

import SwiftUI

struct PokemonImageView: View {
    var evo: PokemonEvolutionContainer?
    var species: PokemonSpeciesContainer?
    @State var evoPokemon: [Pokemon] = []
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(evoPokemon, id: \.id) { pokemon in
                    EvolutionView(pokeomon: pokemon)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        .shadow(radius: 10)
        .onAppear {
            fetchPokeomonData()
        }
    }
    
    func fetchPokeomonData() {
        guard let chain = evo?.chain else { return }
        
        var FirstEvoName = ""
            
        if species?.evolvesFrom == nil {
            // If evolvesFrom is nil, it's the first in the chain
            if let speciesName = species?.name {
                Task {
                    do {
                        if let pokemon = try await PokemonController.getSpecificPokemon(pokemonName: speciesName) {
                            DispatchQueue.main.async {
                                evoPokemon.insert(pokemon, at: 0)
                                FirstEvoName = pokemon.name
                                traverseChain(chain)
                            }
                        }
                    } catch {
                        print("Error fetching pokemon info: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            // If evolvesFrom is not nil, fetch its data first
            if let evolvesFromName = species?.evolvesFrom?.name {
                Task {
                    do {
                        if let pokemon = try await PokemonController.getSpecificPokemon(pokemonName: evolvesFromName) {
                            DispatchQueue.main.async {
                                if evolvesFromName == FirstEvoName {
                                    evoPokemon.insert(pokemon, at: 1)
                                } else {
                                    evoPokemon.append(pokemon)
                                }
                                traverseChain(chain)
                            }
                        }
                    } catch {
                        print("Error fetching pokemon info: \(error.localizedDescription)")
                    }
                }
            }
        }
        
        // Continue traversing the evolution chain
//        traverseChain(chain)
    }
    
    func traverseChain(_ chain: EvolutionChain?) {
        guard let chain = chain else { return }
        
        let speciesName = chain.species.name
        let isAlreadyAdded = evoPokemon.contains { $0.name == speciesName }
        
            Task {
                do {
                    if let pokemon = try await PokemonController.getSpecificPokemon(pokemonName: speciesName) {
                        DispatchQueue.main.async {
                            if !isAlreadyAdded {
                                evoPokemon.append(pokemon)
                            }
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
    let pokeomon: Pokemon
    
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: "\(pokeomon.sprites.front_default)")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 325, height: 80)
            } placeholder: {
                ProgressView()
            }
            Text(pokeomon.name.capitalized)
                .font(.title)
        }
    }
}

#Preview {
    PokemonImageView()
}
