//
//  PokemonMovesModel.swift
//  HolaPokedex
//
//  Created by Afonso Rosa on 04/02/2024.
//

import Foundation

struct PokemonMovesModel: Decodable, Hashable {
    
    let move: PokemonMoveModel
}

struct PokemonMoveModel: Decodable, Hashable {
    
    let name: String
    let url: URL
}
