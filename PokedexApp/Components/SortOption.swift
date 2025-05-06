//
//  SortOption.swift
//  PokedexApp
//
//  Created by Bartosz Mrugała on 06/05/2025.
//

import Foundation

enum SortOption: String, CaseIterable, Identifiable {
    case id =  "ID"
    case name = "A-Z"
    case favorites = "Favorites"
    
    var id: String { rawValue }
}
