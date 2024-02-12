//
//  PokemonModel.swift
//  HolaPokedex
//
//  Created by Afonso Rosa on 04/02/2024.
//

import Foundation

class PokemonModel: Decodable, Hashable {

    let abilities: [PokemonAbilitiesModel]
    let id: Int
    let moves: [PokemonMovesModel]
    let name: String
    let sprites: PokemonSpritesModel
    let types: [PokemonTypeModel]

    init(abilities: [PokemonAbilitiesModel], id: Int, moves: [PokemonMovesModel], name: String, sprites: PokemonSpritesModel, types: [PokemonTypeModel]) {
        self.abilities = abilities
        self.id = id
        self.moves = moves
        self.name = name
        self.sprites = sprites
        self.types = types
    }

    static func == (lhs: PokemonModel, rhs: PokemonModel) -> Bool {
        
        return lhs.abilities == rhs.abilities &&
        lhs.id == rhs.id &&
        lhs.moves == rhs.moves &&
        lhs.name == rhs.name &&
        lhs.sprites == rhs.sprites
        && lhs.types == rhs.types
    }

    func hash(into hasher: inout Hasher) {

        hasher.combine(self.abilities)
        hasher.combine(self.id)
        hasher.combine(self.moves)
        hasher.combine(self.name)
        hasher.combine(self.sprites)
        hasher.combine(self.types)
    }
}


