//
//  PokemonSpritesModel.swift
//  HolaPokedex
//
//  Created by Afonso Rosa on 04/02/2024.
//

import Foundation

struct PokemonSpritesModel: Decodable, Hashable {
    
    let frontDefault: URL
    
    enum CodingKeys: String, CodingKey {

        case frontDefault = "front_default"
    }
}
