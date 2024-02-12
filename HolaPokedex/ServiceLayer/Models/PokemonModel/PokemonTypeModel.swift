//
//  PokemonTypeModel.swift
//  HolaPokedex
//
//  Created by Afonso Rosa on 04/02/2024.
//

import Foundation

struct PokemonTypeModel: Decodable, Hashable {
    
    let slot: Int
    let type: PokemonType
    
    enum CodingKeys: String, CodingKey {

        case slot
        case type
    }
    
    enum TypeKeys: String, CodingKey {

        case name
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.slot = try container.decode(Int.self, forKey: .slot)
        
        let typeContainer = try container.nestedContainer(keyedBy: TypeKeys.self, forKey: .type)
        let typeName = try typeContainer.decode(String.self, forKey: .name)
        
        self.type = PokemonType(with: typeName)
    }
    
    init(slot: Int, type: PokemonType) {
        
        self.slot = slot
        self.type = type
    }
}

enum PokemonType {
    
    case bug
    case dark
    case dragon
    case electric
    case fairy
    case fire
    case fighting
    case flying
    case ice
    case ghost
    case grass
    case ground
    case normal
    case poison
    case psychic
    case rock
    case steel
    case water
    case undefined
    
    init(with name: String) {
        
        switch name {
            
        case "bug":
            self = .bug

        case "dark":
            self = .dark

        case "dragon":
            self = .dragon

        case "electric":
            self = .electric

        case "fairy":
            self = .fairy

        case "fire":
            self = .fire

        case "fighting":
            self = .fighting

        case "flying":
            self = .flying

        case "ice":
            self = .ice

        case "ghost":
            self = .ghost

        case "grass":
            self = .grass

        case "ground":
            self = .ground

        case "normal":
            self = .normal
            
        case "poison":
            self = .poison

        case "psychic":
            self = .psychic

        case "rock":
            self = .rock

        case "steel":
            self = .steel

        case "water":
            self = .water
            
        default:
            print(name)
            self = .undefined
        }
    }
    
    var name: String {
        
        switch self {
            
        case .bug:
            return "Bug"

        case .dark:
            return "Dark"

        case .dragon:
            return "Dragon"

        case .electric:
            return "Electric"

        case .fairy:
            return "Fairy"

        case .fire:
            return "Fire"

        case .fighting:
            return "Fighting"

        case .flying:
            return "Flying"

        case .ice:
            return "Ice"

        case .ghost:
            return "Ghost"

        case .grass:
            return "Grass"

        case .ground:
            return "Ground"

        case .normal:
            return "Normal"
            
        case .poison:
            return "Poison"

        case .psychic:
            return "Psychic"

        case .rock:
            return "Rock"

        case .steel:
            return "Steel"

        case .water:
            return "Water"
            
        case .undefined:
            return ""
        }
    }
}
