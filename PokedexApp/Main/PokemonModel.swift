//
//  Model.swift
//  PokedexApp
//
//  Created by Bartosz Mrugała on 29/04/2025.
//

import SwiftUI

struct Pokemon: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let url: String

    var pokemonID: Int? {
        guard let urlComponents = URL(string: url)?.pathComponents else { return nil }
        if let idString = urlComponents.last(where: { !$0.isEmpty }), let id = Int(idString) {
            return id
        }
        return nil
    }

    var imageUrl: URL? {
        guard let id = pokemonID else { return nil }
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }

    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

struct PokemonResponse: Decodable {
    let results: [Pokemon]
}
