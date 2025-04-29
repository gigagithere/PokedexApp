//
//  DetailView.swift
//  PokedexApp
//
//  Created by Bartosz Mrugała on 29/04/2025.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @State private var selectedSection: DetailSection = .info
    @State private var isLiked: Bool = false
    @State private var isAnimatingHeart = false

    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
            
                AsyncImage(url: pokemon.imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)                    
                } placeholder: {
                    ProgressView()
                        .frame(width: 200, height: 200)
                }
                
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .bold()
                
                Picker("Section", selection: $selectedSection) {
                    ForEach(DetailSection.allCases) { section in
                        Text(section.rawValue).tag(section)
                    }
                }
                
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                sectionContent
                
            }
            .padding()
        }
        .navigationTitle(pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HeartButton(isLiked: $isLiked)
            }
        }
    }
    
    // MARK: - Enum
    enum DetailSection: String, CaseIterable, Identifiable {
        case info = "Info"
        case stats = "Stats"
        case evolution = "Evolution"
        
        var id: String { rawValue }
    }
    
    // MARK: - Computed Properties
    private var sectionContent: some View {
        VStack {
            switch selectedSection {
            case .info:
                CardView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Basic information about the Pokémon will go here.")
                        Text("Example: ID \(pokemon.pokemonID ?? 0)")
                    }
                }
                
            case .stats:
                CardView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Stats section (placeholder).")
                        Text("Later you can show Attack, Defense, etc.")
                    }
                }
                
            case .evolution:
                CardView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Evolution chain will go here.")
                        Text("Example: Bulbasaur → Ivysaur → Venusaur")
                    }
                }
            }
        }
        .animation(.easeInOut, value: selectedSection)
    }
}

// MARK: - Container View
struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemGray6))
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            )
            .padding(.horizontal)
    }
}



#Preview {
    NavigationStack {
        PokemonDetailView(
            pokemon: .init(
                name: "bulbasaur",
                url: "https://pokeapi.co/api/v2/pokemon/1/"
            )
        )
    }
}
