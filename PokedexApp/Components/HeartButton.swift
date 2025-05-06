//
//  HeartButton.swift
//  PokedexApp
//
//  Created by Bartosz Mrugała on 29/04/2025.
//

import SwiftUI

struct HeartButton: View {
    let pokemon: Pokemon
    @State private var isAnimating = false
    @ObservedObject var viewModel: PokemonViewModel
    
    var body: some View {
        Button(action: {
            viewModel.toggleFavorite(for: pokemon)
            animateHeart()
        }) {
            Image(systemName: viewModel.isFavorite(pokemon) ? "heart.fill" : "heart")
                .scaleEffect(isAnimating ? 1.3 : 1.0)
                .foregroundColor(viewModel.isFavorite(pokemon) ? .red : .gray)
                .font(.title2)
        }
    }
    
    private func animateHeart() {
        withAnimation(.easeInOut(duration: 0.2)) {
            isAnimating = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeInOut(duration: 0.2)) {
                isAnimating = false
            }
        }
    }
}

#Preview {
    HeartButton(
        pokemon: .init(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
        viewModel: PokemonViewModel()
    )
}
