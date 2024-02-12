//
//  PokemonAbilitiesModel.swift
//  HolaPokedex
//
//  Created by Afonso Rosa on 04/02/2024.
//

import Foundation

struct PokemonAbilitiesModel: Decodable, Hashable {
    
    let ability: PokemonAbilityModel
    let isHidden: Bool
    let slot: Int
    
    enum CodingKeys: String, CodingKey {

        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct PokemonAbilityModel: Decodable, Hashable {
    
    let name: String
    let url: URL
}
