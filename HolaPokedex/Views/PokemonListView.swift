//
//  PokemonListView.swift
//  HolaPokedex
//
//  Created by Afonso Rosa on 04/02/2024.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel: PokemonListViewModel

    var body: some View {

        VStack(alignment: .leading, spacing: 5) {
            Text("Pokédex")
                .font(.largeTitle)
                .multilineTextAlignment(.leading)

            Text("Use the advanced search to find Pokémon by type, weakness, ability and more!")
                .multilineTextAlignment(.leading)
        }
        .padding()

        NavigationStack {

            List {
                ForEach($viewModel.pokemonList, id: \.self) { pokemon in

                    NavigationLink(value: pokemon.wrappedValue) {
                        PokemonSummaryCell(pokemonSummary: pokemon.wrappedValue)
                            .onAppear {
                                self.viewModel.fetchPokemon(pokemon.wrappedValue)
                            }
                            .frame(height: 100)
                    }
                }
            }
            .padding()
            .toolbar {
                ToolbarItem {
                    HStack {
                        TextField($viewModel.filter.wrappedValue.searchText, text: $viewModel.searchText)

                        Button("Tap to change Filter") {
                            self.viewModel.filterTapped()
                        }
                    }
                }
            }
            .navigationDestination(for: PokemonSummaryModel.self) { pokemonSummaryModel in

                if let pokemonModel = pokemonSummaryModel.pokemonModel {

                    PokemonDetailView(viewModel: PokemonDetailViewModel(pokemon: pokemonModel))
                }
            }
        }
        .navigationTitle("Pokemon List")
        //.searchable(text: $viewModel.searchText)
        .onAppear {
            self.viewModel.viewDidLoad()
        }
    }
}

#Preview {
    PokemonListView(viewModel: PokemonListViewModel(cacheManager: CacheManager()))
}
