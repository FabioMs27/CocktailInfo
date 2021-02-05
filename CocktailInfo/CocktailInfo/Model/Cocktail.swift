//
//  Cocktail.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 05/02/21.
//

import Foundation

struct Cocktail {
    let name: String
    let category: String
    let alcoholic: String
    let glass: String
    let instructions: String
    let thumbNailUrl: URL
    let dateModified: Date
}

extension Cocktail: Decodable {
    enum CodingKeys: String, CodingKey {
        case name         = "strDrink"
        case category     = "strCategory"
        case alcoholic    = "strAlcoholic"
        case glass        = "strGlass"
        case instructions = "strInstructions"
        case thumbNailUrl = "strDrinkThumb"
        case dateModified
    }
}

struct Drinks {
    let drinks: [Cocktail]
}

extension Drinks: Decodable {
    enum CodingKeys: String, CodingKey {
        case drinks
    }
}
