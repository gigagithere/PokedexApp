//
//  ViewModel.swift
//  PokedexApp
//
//  Created by Bartosz Mrugała on 29/04/2025.
//

import Foundation
import SwiftUI

// MARK: - ViewModel
class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []

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
}
