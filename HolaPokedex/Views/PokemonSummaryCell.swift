//
//  PokemonSummaryCell.swift
//  HolaPokedex
//
//  Created by Afonso Rosa on 04/02/2024.
//

import SwiftUI
import Kingfisher

struct PokemonSummaryCell: View {
    @ObservedObject var pokemonSummary: PokemonSummaryModel
    
    var body: some View {
        
        HStack {
            Text(self.pokemonSummary.name)
            
            Spacer()
            
            KFImage($pokemonSummary.imageURL.wrappedValue)
            
            VStack {
                ForEach($pokemonSummary.types, id: \.self) { type in
                    
                    Text(type.wrappedValue)
                }
            }
        }
    }
}

#Preview {
    PokemonSummaryCell(pokemonSummary: PokemonSummaryModel(name: "Charmander"))
}
