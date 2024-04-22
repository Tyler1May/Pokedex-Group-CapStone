//
//  PokemonStatusChart.swift
//  Pokedex
//
//  Created by Tyler May on 4/19/24.
//

import SwiftUI
import Charts

struct PokemonStatusChart: View {
    var stats: [PokemonStatsContainer]

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Stats")
                .font(.title)
            ForEach(stats, id: \.stat.name) { stat in
                HStack(spacing: 5) {
                    Text(stat.stat.name.capitalized)
                        .frame(width: 75, alignment: .leading)
                    RoundedShape(corners: [.topRight, .bottomRight])
                        .fill(self.barColor(for: stat.stat.name))
                        .frame(width: CGFloat(stat.baseStat), height: 20)
                    Text("\(stat.baseStat)")
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray5))
        .clipShape(RoundedShape(corners: [.allCorners]))
        .padding()
        .shadow(radius: 10)
        
    }
    
    func barColor(for statName: String) -> Color {
        switch statName {
        case "hp":
            return .green
        case "attack":
            return .red
        case "defense":
            return .blue
        case "special-attack":
            return .red
        case "special-defense":
            return .blue
        case "speed":
            return .cyan
        default:
            return .gray
        }
    }
}

#Preview {
    PokemonStatusChart(stats: [
        PokemonStatsContainer(baseStat: 15, stat: PokemonStat(name: "hp")),
        PokemonStatsContainer(baseStat: 12, stat: PokemonStat(name: "attack")),
        PokemonStatsContainer(baseStat: 6, stat: PokemonStat(name: "defence"))
    ])
}
