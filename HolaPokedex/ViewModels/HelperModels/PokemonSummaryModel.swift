//
//  PokemonSummaryModel.swift
//  HolaPokedex
//
//  Created by Afonso Rosa on 04/02/2024.
//

import Foundation

class PokemonSummaryModel: Hashable, Identifiable, ObservableObject {
    
    let id: String
    let name: String
    @Published var types = [String]()
    @Published var imageURL = URL(string: "")
    @Published var pokemonModel: PokemonModel?
    var abilities = [String]()

    init(name: String) {
        
        self.id = UUID().uuidString
        self.name = name
    }
    
    init?(with itemModel: PokemonItemModel) {
        
        guard let id = itemModel.id else { return nil }
        
        self.id = id
        self.name = itemModel.name
    }
    
    func update(with pokemonModel: PokemonModel) {
        
        self.pokemonModel = pokemonModel
        self.types = pokemonModel.types.map { $0.type.name }
        self.imageURL = pokemonModel.sprites.frontDefault
        self.abilities = pokemonModel.abilities.map { $0.ability.name }
    }
}

extension PokemonSummaryModel {
    
    static func == (lhs: PokemonSummaryModel, rhs: PokemonSummaryModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
