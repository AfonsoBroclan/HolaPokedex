//
//  PokemonListViewModelTests.swift
//  HolaPokedexTests
//
//  Created by Afonso Rosa on 04/02/2024.
//

import Combine
import XCTest
@testable import HolaPokedex

final class PokemonListViewModelTests: XCTestCase {

    var viewModel: PokemonListViewModel?

    override func setUp() {
        super.setUp()

        self.viewModel = PokemonListViewModel(with: ServiceLayerMock(), cacheManager: CacheManager())
    }

    override func tearDown() {
        super.tearDown()

        self.viewModel = nil
    }

    func testFetchPokemons() {

        let expectation = XCTestExpectation(description: "waiting for pokemons")

        let sink = self.viewModel?.$pokemonList.sink { pokemonSummaries in

            if pokemonSummaries.isEmpty == false {

                XCTAssertEqual(pokemonSummaries.count, 20)

                let firstPokemon = pokemonSummaries.first

                XCTAssertEqual(firstPokemon?.id, "1")
                XCTAssertEqual(firstPokemon?.name, "bulbasaur")
                XCTAssertEqual(firstPokemon?.types, [])
                XCTAssertNil(firstPokemon?.imageURL)
                XCTAssertNil(firstPokemon?.pokemonModel)
                expectation.fulfill()
            }
        }

        self.viewModel?.viewDidLoad()

        wait(for: [expectation], timeout: 1)

        sink?.cancel()
    }

    func testFetchSinglePokemon() {

        let expectation = XCTestExpectation(description: "waiting for pokemons")
        var pokemonSink: AnyCancellable?

        let sink = self.viewModel?.$pokemonList.sink { [weak self] pokemonSummaries in

            if let firstPokemon = pokemonSummaries.first {

                pokemonSink = firstPokemon.$pokemonModel.sink { pokemon in

                    if pokemon != nil {

                        XCTAssertEqual(pokemon?.name, "ditto")
                        XCTAssertEqual(pokemon?.id, 132)
                        XCTAssertEqual(pokemon?.moves.count, 1)
                        XCTAssertNotNil(pokemon?.sprites.frontDefault)
                        XCTAssertEqual(pokemon?.types.count, 1)
                        expectation.fulfill()
                    }
                }

                self?.viewModel?.fetchPokemon(firstPokemon)
            }
        }

        self.viewModel?.viewDidLoad()

        wait(for: [expectation], timeout: 1)

        sink?.cancel()
        pokemonSink?.cancel()
    }
}
