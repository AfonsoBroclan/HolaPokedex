//
//  PokemonListViewModel.swift
//  HolaPokedex
//
//  Created by Afonso Rosa on 04/02/2024.
//

import Foundation

enum FilterType {

    case name
    case type
    case ability

    var searchText: String {

        switch self {
        case .name:
            "Filter By Pokémon Name"
        case .type:
            "Filter By Pokémon Type"
        case .ability:
            "Filter By Pokémon Ability"
        }
    }
}

class PokemonListViewModel: ObservableObject {
    
    private enum Constants {
        
        static let pageLimit = 20
        static let offsetToLoad = 6
    }
    
    private let serviceLayer: API
    private let cacheManager: CacheManager
    private var currentOffset = 0
    private var maxPokemon = Int.max
    private var pokemons = [PokemonSummaryModel]()

    @Published var pokemonList = [PokemonSummaryModel]()

    private var canFetchMore: Bool {

        self.currentOffset + Constants.pageLimit < self.maxPokemon
    }

    @Published var searchText = "" {

        didSet {
            self.updatePokemonList()
        }
    }

    @Published var filter = FilterType.name

    init(with serviceLayer: API = ServiceLayer(), cacheManager: CacheManager) {

        self.serviceLayer = serviceLayer
        self.cacheManager = cacheManager
    }
    
    func viewDidLoad() {

        self.fetchPokemons()
    }

    func fetchPokemon(_ pokemon: PokemonSummaryModel) {
        
        if Int(pokemon.id) == nil {
            
            assertionFailure("Invalid ID for :\(pokemon.name)")
            return
        }

        self.fetchPokemon(with: pokemon.id)

        if self.pokemonList.count > Constants.offsetToLoad,
           pokemon == self.pokemonList[self.pokemonList.count - Constants.offsetToLoad],
           self.canFetchMore {

            self.fetchPokemons()

        } else if pokemon == self.pokemonList.last,
                  self.canFetchMore {

            self.fetchPokemons()
        }
    }

    func filterTapped() {
        
        switch self.filter {

        case .name:
            self.filter = .type
        case .type:
            self.filter = .ability
        case .ability:
            self.filter = .name
        }
    }
}

private extension PokemonListViewModel {

    func updatePokemonList() {
        
        if self.searchText.isEmpty {

            self.pokemonList = self.pokemons

        } else {

            self.pokemonList = self.pokemons.filter { pokemonSummary in

                switch self.filter {

                case .name:
                    pokemonSummary.name.lowercased().contains(self.searchText.lowercased())
                case .type:
                    pokemonSummary.types.contains { $0.lowercased().contains(self.searchText.lowercased()) }
                case .ability:
                    pokemonSummary.abilities.contains { $0.lowercased().contains(self.searchText.lowercased()) }
                }
            }
        }
    }

    func fetchPokemons() {

        let allCachedPokemonSummaries = self.cacheManager.allPokemonSummaries
        
        if allCachedPokemonSummaries.count == self.maxPokemon {
            
            DispatchQueue.main.async {
                
                self.pokemons = allCachedPokemonSummaries
                self.updatePokemonList()
            }
        } else {
            
            Task {
                let result = try? await self.serviceLayer.fetchPokemons(with: Constants.pageLimit, offset: self.currentOffset)
                
                if let (pokemonList, error) = result,
                   error == nil {
                    
                    self.maxPokemon = pokemonList?.count ?? self.maxPokemon
                    self.currentOffset += Constants.pageLimit
                    let pokemonSummaries = pokemonList?.results.compactMap { PokemonSummaryModel(with: $0) }
                    
                    DispatchQueue.main.async {
                        
                        self.pokemons.append(contentsOf: pokemonSummaries ?? [])
                        self.updatePokemonList()
                        
                        pokemonSummaries?.forEach { self.cacheManager.addPokemonSummary($0) }
                    }
                    
                } else {
                    
                    print("Something went wrong...")
                }
            }
        }
    }
    
    func fetchPokemon(with id: String) {
        
        Task {

            if let pokemon = self.cacheManager.fetchPokemon(for: Int(id) ?? -1) {
                
                DispatchQueue.main.async {

                    self.pokemons.first { $0.id == id }?.update(with: pokemon)
                    self.pokemonList.first { $0.id == id }?.update(with: pokemon)
                }
            } else {

                let result = try? await self.serviceLayer.fetchPokemon(with: id)

                if let (pokemon, error) = result,
                   error == nil,
                   let pokemon {

                    DispatchQueue.main.async {

                        self.pokemons.first { $0.id == id }?.update(with: pokemon)
                        self.pokemonList.first { $0.id == id }?.update(with: pokemon)
                        self.cacheManager.addPokemon(pokemon)
                    }

                } else {

                    print("Something went wrong...")
                }
            }
        }
    }
}
