//
//  ServiceLayerMock.swift
//  HolaPokedexTests
//
//  Created by Afonso Rosa on 05/02/2024.
//

import XCTest
@testable import HolaPokedex

struct ServiceLayerMock: API {

    func fetchPokemon(with id: String) async throws -> PokemonByIDResult {

        if let url = Bundle(for: PokemonListViewModelTests.self).url(forResource: "pokemon", withExtension: "json") {

            let data = try Data(contentsOf: url)

            let pokemon = try JSONDecoder().decode(PokemonModel.self, from: data)

            return PokemonByIDResult(pokemon, nil)
        }

        return PokemonByIDResult(nil, .invalidJSON)
    }

    func fetchPokemons(with limit: Int, offset: Int) async throws -> PokemonListResult {

        if let url = Bundle(for: PokemonListViewModelTests.self).url(forResource: "pokemonSummaries", withExtension: "json") {

            let data = try Data(contentsOf: url)

            let pokemonList = try JSONDecoder().decode(PokemonListModel.self, from: data)

            return PokemonListResult(pokemonList, nil)
        }

        return PokemonListResult(nil, .invalidJSON)
    }
}
