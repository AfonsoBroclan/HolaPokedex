//
//  CacheManager.swift
//  HolaPokedex
//
//  Created by Afonso Rosa on 05/02/2024.
//

import Foundation

class CacheManager {

    private let pokemonSummariesCache = NSCache<NSNumber, PokemonSummaryModel>()
    private var pokemonSummariesIDs = Set<NSNumber>()
    private let pokemonCache = NSCache<NSNumber, PokemonModel>()
    private var pokemonIDs = Set<NSNumber>()

    func addPokemonSummary(_ pokemon: PokemonSummaryModel) {

        let id = NSNumber(value: Int(pokemon.id) ?? -1)
        self.pokemonSummariesCache.setObject(pokemon, forKey: id)
        self.pokemonSummariesIDs.insert(id)
    }

    var allPokemonSummaries: [PokemonSummaryModel] {

        self.pokemonSummariesIDs.compactMap { self.pokemonSummariesCache.object(forKey: $0) }
    }

    func addPokemon(_ pokemon: PokemonModel) {

        let id = NSNumber(value: pokemon.id)
        self.pokemonCache.setObject(pokemon, forKey: id)
        self.pokemonIDs.insert(id)
    }

    var allPokemon: [PokemonModel] {

        self.pokemonIDs.compactMap { self.pokemonCache.object(forKey: $0) }
    }

    func fetchPokemon(for id: Int) -> PokemonModel? {

        self.pokemonCache.object(forKey: NSNumber(value: id))
    }

    func flush() {

        self.pokemonSummariesCache.removeAllObjects()
        self.pokemonSummariesIDs.removeAll()
        self.pokemonCache.removeAllObjects()
        self.pokemonIDs.removeAll()
    }
}
