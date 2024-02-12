//
//  PokemonDetailView.swift
//  HolaPokedex
//
//  Created by Afonso Rosa on 04/02/2024.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    let viewModel: PokemonDetailViewModel
    
    var body: some View {
        VStack {
            
            Text(self.viewModel.pokemon.name)
                .bold()
                .font(.largeTitle)
            
            KFImage(self.viewModel.pokemon.sprites.frontDefault)
            
            HStack {
                ForEach(self.viewModel.types, id: \.self) { type in
                    Text(type)
                }
            }
            
            Divider()
            
            HStack {
                ForEach(self.viewModel.abilities, id: \.self) { ability in
                    Text(ability)
                }
            }
            
            Divider()
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(self.viewModel.moves, id: \.self) { move in
                        Text(move)
                    }
                }
                .padding()
            }
            .frame(height: 100)
        }
    }
}

#Preview {
    PokemonDetailView(viewModel:
                        PokemonDetailViewModel(pokemon:
                                                PokemonModel(abilities:
                                                                [PokemonAbilitiesModel(ability:
                                                                                        PokemonAbilityModel(name: "blaze",
                                                                                                            url: URL(string: "https://pokeapi.co/api/v2/ability/66/")!),
                                                                                       isHidden: false,
                                                                                       slot: 1)],
                                                             id: 4,
                                                             moves: [PokemonMovesModel(move:
                                                                                        PokemonMoveModel(name: "mega-punch",
                                                                                                         url: URL(string: "https://pokeapi.co/api/v2/move/5/")!))],
                                                             name: "Charmander",
                                                             sprites: PokemonSpritesModel(frontDefault: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png")!),
                                                             types: [PokemonTypeModel(slot: 1, type: .fire)])))
}
