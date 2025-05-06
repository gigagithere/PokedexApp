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
    @State private var selectedSort: SortOption = .id
    @State private var isSortReversed: Bool = false
    @State private var searchText: String = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Picker("Sort", selection: $selectedSort) {
                            ForEach(SortOption.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Button(action: {
                            withAnimation(.easeInOut) {
                                isSortReversed.toggle()
                            }
                        }) {
                            Image(systemName:"arrow.up.arrow.down")
                                .imageScale(.small)
                                .padding(8)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                                .foregroundColor(.black)
                            
                        }
                    }
                    .padding(.horizontal)
                }
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(filteredAndSortedPokemons) { pokemon in
                        NavigationLink(
                            destination: PokemonDetailView(pokemon: pokemon, viewModel: viewModel)
                        ) {
                            PokemonCell(pokemon: pokemon, viewModel: viewModel)
                        }
                    }
                }
                .padding()
                .tint(.black)
            }
            .searchable(text: $searchText, prompt: "Search")
            .navigationTitle("Pokedex")
        }
        .task {
            await viewModel.fetchPokemons()
        }
    }
    
    
    private var filteredAndSortedPokemons: [Pokemon] {
        let filtered = viewModel.pokemons.filter { pokemon in
            searchText.isEmpty || pokemon.name.localizedCaseInsensitiveContains(searchText)
        }
        let sorted: [Pokemon]
        switch selectedSort {
        case .id:
            sorted = filtered.sorted { ($0.pokemonID ?? 0) < ($1.pokemonID ?? 0) }
        case .name:
            sorted = filtered.sorted { $0.name.lowercased() < $1.name.lowercased() }
        case .favorites:
            sorted = filtered.filter { viewModel.isFavorite($0) }
        }
        
        return isSortReversed ? sorted.reversed() : sorted
    }
}

#Preview {
    PokedexView()
}
