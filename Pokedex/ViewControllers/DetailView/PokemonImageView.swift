//
//  PokemonImageView.swift
//  Pokedex
//
//  Created by Tyler May on 4/19/24.
//

import SwiftUI

struct PokemonImageView: View {
    var image: PokemonSprites?
    var evo: PokemonEvolutionContainer?
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(extractEvolutionSpecies(from: evo?.chain), id: \.self) { species in
                    EvolutionView(species: species)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        .shadow(radius: 10)
    }
    
    func extractEvolutionSpecies(from chain: EvolutionChain?) -> [SpeciesContainer] {
        var species: [SpeciesContainer] = []
        
        func traverseChain(_ chain: EvolutionChain?) {
            guard let chain = chain else { return }
            species.append(chain.species)
            
            for evolution in chain.evolvesTo {
                traverseChain(evolution)
            }
        }
        
        traverseChain(chain)
        
        return species
    }
    
}

struct EvolutionView: View {
    let species: SpeciesContainer
    
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: "\(species.url)")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 325, height: 80)
            } placeholder: {
                ProgressView()
            }
            Text(species.name.capitalized)
                .font(.title)
        }
    }
}

#Preview {
    PokemonImageView()
}
