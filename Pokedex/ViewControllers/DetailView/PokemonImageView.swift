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
        traverseChain(chain)
    }
    
    func traverseChain(_ chain: EvolutionChain?) {
            guard let chain = chain else { return }
            
        let speciesName = chain.species.name
            Task {
                do {
                    if let pokemon = try await PokemonController.getSpecificPokemon(pokemonName: speciesName) {
                        DispatchQueue.main.async {
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
    
//    func extractEvolutionSpecies(from chain: EvolutionChain?) -> [SpeciesContainer] {
//        var species: [SpeciesContainer] = []
//        
//        func traverseChain(_ chain: EvolutionChain?) {
//            guard let chain = chain else { return }
//            species.append(chain.species)
//            
//            for evolution in chain.evolvesTo {
//                traverseChain(evolution)
//            }
//        }
//        
//        traverseChain(chain)
//        return species
//    }
//    
//    func extractPokemonInfo(from species: String) -> Pokemon {
//        Task {
//            do {
//                if let pokemon = try await PokemonController.getSpecificPokemon(pokemonName: species) {
//                    return pokemon
//                }
//            } catch {
//                print("Error fetching pokemon info: \(error.localizedDescription)")
//            }
//        }
//        return
//    
//    }
    
        
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
