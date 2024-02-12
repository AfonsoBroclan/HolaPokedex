//
//  PokemonListModel.swift
//  HolaPokedex
//
//  Created by Afonso Rosa on 04/02/2024.
//

import Foundation

struct PokemonListModel: Decodable {
    
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [PokemonItemModel]
}

struct PokemonItemModel: Decodable {
    
    let name: String
    let url: URL
    
    var id: String? {
        
        self.url.absoluteString.components(separatedBy: "/").first { Int($0) != nil }
    }
}
