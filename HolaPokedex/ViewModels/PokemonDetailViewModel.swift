//
//  PokemonDetailViewModel.swift
//  HolaPokedex
//
//  Created by Afonso Rosa on 04/02/2024.
//

import Foundation

class PokemonDetailViewModel: ObservableObject {
    
    let pokemon: PokemonModel
    
    var abilities: [String] {
        self.pokemon.abilities.compactMap {
            
            if $0.isHidden == false {
                
                return $0.ability.name
            }
            
            return nil
        }
    }
    
    var moves: [String] {
        self.pokemon.moves.map { $0.move.name }
    }
    
    var types: [String] {
        self.pokemon.types.map { $0.type.name }
    }
    
    init(pokemon: PokemonModel) {
        self.pokemon = pokemon
    }
}
