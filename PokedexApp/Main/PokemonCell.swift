//
//  PokemonCell.swift
//  PokedexApp
//
//  Created by Bartosz Mrugała on 29/04/2025.
//

import SwiftUI

struct PokemonCell: View {
    let pokemon: Pokemon
    @State private var isLiked = false
    @ObservedObject var viewModel: PokemonViewModel
    
    
    var body: some View {
        VStack(spacing: 0) {
            if let imageUrl = pokemon.imageUrl {
                AsyncImage(url: imageUrl) { image in
                    image.resizable().scaledToFit().frame(width: 80, height: 80)
                } placeholder: {
                    ProgressView()
                }
            }
            Text(pokemon.name.capitalized)
                .font(.headline)
                .padding(5)
            
            Divider()
            
            ZStack {
                Color.gray.opacity(0.1)
                HeartButton(pokemon: pokemon, viewModel: viewModel)
            }
            .frame(height: 30)
            .foregroundStyle(.red.opacity(0.8))
        }
        .frame(height: 150, alignment: .bottom)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
    }
    
}

#Preview {
    PokemonCell(
        pokemon: .init(
            name: "bulbasaur",
            url: "https://pokeapi.co/api/v2/pokemon/1/"
        ), viewModel: PokemonViewModel()
    )
}
