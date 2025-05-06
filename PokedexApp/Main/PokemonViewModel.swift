//
//  ViewModel.swift
//  PokedexApp
//
//  Created by Bartosz Mrugała on 29/04/2025.
//

import Foundation
import SwiftUI

// MARK: - ViewModel
@MainActor
class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var favorites: Set<Int> = []
    
    func fetchPokemons() async {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(PokemonResponse.self, from: data)
            self.pokemons = decoded.results
        } catch {
            print("Failed to fetch pokemons: \(error)")
        }
    }
    
    func toggleFavorite(for pokemon: Pokemon) {
        guard let id = pokemon.pokemonID else { return }
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
    }
    
    func isFavorite(_ pokemon: Pokemon) -> Bool {
        guard let id = pokemon.pokemonID else { return false }
        return favorites.contains(id)
    }
}
