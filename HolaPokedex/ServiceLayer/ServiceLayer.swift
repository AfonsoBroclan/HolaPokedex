//
//  ServiceLayer.swift
//  HolaPokedex
//
//  Created by Afonso Rosa on 04/02/2024.
//

import Foundation

enum CustomErrors: Error {

    case invalidURL
    case invalidJSON
}

typealias PokemonListResult = (PokemonListModel?, CustomErrors?)
typealias PokemonByIDResult = (PokemonModel?, CustomErrors?)

protocol API {

    func fetchPokemons(with limit: Int, offset: Int) async throws -> PokemonListResult
    func fetchPokemon(with id: String) async throws -> PokemonByIDResult
}

struct ServiceLayer: API {

    private enum Constants {

        static let pokemonListBaseLink = "https://pokeapi.co/api/v2/pokemon"
        static let limitKey = "limit"
        static let offsetKey = "offset"
    }

    func fetchPokemons(with limit: Int, offset: Int) async throws -> PokemonListResult {
        
        let pokemonLink = "\(Constants.pokemonListBaseLink)?\(Constants.limitKey)=\(limit)&\(Constants.offsetKey)=\(offset)"

        guard let url = URL(string: pokemonLink) else { return (nil, .invalidURL) }

        let (data, _) = try await URLSession.shared.data(from: url)

        if let pokemonList = try? JSONDecoder().decode(PokemonListModel.self, from: data) {

            return (pokemonList, nil)

        } else {

            return (nil, .invalidJSON)
        }
    }
    
    func fetchPokemon(with id: String) async throws -> PokemonByIDResult {
        
        let pokemonLink = "\(Constants.pokemonListBaseLink)/\(id)"

        guard let url = URL(string: pokemonLink) else { return (nil, .invalidURL) }

        let (data, _) = try await URLSession.shared.data(from: url)

        if let pokemon = try? JSONDecoder().decode(PokemonModel.self, from: data) {

            return (pokemon, nil)

        } else {

            return (nil, .invalidJSON)
        }
    }
}
