//
//  HolaPokedexApp.swift
//  HolaPokedex
//
//  Created by Afonso Rosa on 04/02/2024.
//

import SwiftUI

@main
struct HolaPokedexApp: App {

    let cacheManager = CacheManager()

    var body: some Scene {
        WindowGroup {
            PokemonListView(viewModel: PokemonListViewModel(cacheManager: self.cacheManager))
        }
    }
}
