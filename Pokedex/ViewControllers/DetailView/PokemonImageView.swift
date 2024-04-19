//
//  PokemonImageView.swift
//  Pokedex
//
//  Created by Tyler May on 4/19/24.
//

import SwiftUI

struct PokemonImageView: View {
    var image: PokemonSprites?
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: "\(image)")) { image in
                        image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 325, height: 100)
                } placeholder: {
                    ProgressView()
                }
                    Text("Evo 1")
                        .font(.largeTitle)
                }
                
                VStack(alignment: .center) {
                    Image(systemName: "person.fill")
                        .frame(width: 325, height: 100)
                    Text("Evo 2")
                        .font(.largeTitle)
                }
                
                VStack(alignment: .center) {
                    Image(systemName: "person.circle.fill")
                        .frame(width: 325, height: 100)
                    Text("Evo 3")
                        .font(.largeTitle)
                }
                
            }
        }
        .padding()
        .background(Color(.systemGray5))
        .clipShape(RoundedShape(corners: [.allCorners]))
        .padding()
        .shadow(radius: 10)
    }
}

#Preview {
    PokemonImageView()
}
