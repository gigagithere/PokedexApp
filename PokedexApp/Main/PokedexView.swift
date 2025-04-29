//
//  View.swift
//  PokedexApp
//
//  Created by Bartosz Mrugała on 29/04/2025.
//

import SwiftUI

struct PokedexView: View {
    @StateObject private var viewModel = PokemonViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var isLiked = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.pokemons) { pokemon in
                        PokemonCell(pokemon: pokemon)
                    }
                }
                .padding()
            }
            .navigationTitle("Pokedex")
        }
        .task {
            await viewModel.fetchPokemons()
        }
    }
}

#Preview {
    PokedexView()
}
