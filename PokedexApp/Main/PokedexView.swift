//
//  View.swift
//  PokedexApp
//
//  Created by Bartosz Mrugała on 29/04/2025.
//

import SwiftUI

struct PokedexView: View {
    @StateObject private var viewModel = PokemonViewModel()
    @State var isLiked = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.pokemons) { pokemon in
                        NavigationLink(
                            destination: PokemonDetailView(pokemon: pokemon)
                        ) {
                            PokemonCell(pokemon: pokemon)
                        }
                    }
                }
                
                .padding()
                .tint(.black)
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
