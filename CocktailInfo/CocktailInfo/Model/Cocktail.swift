//
//  Cocktail.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 05/02/21.
//

import Foundation
import UIKit

/// Model representing the cocktail api's data.
struct Cocktail {
    let id: String
    let name: String
    let category: String
    let alcoholic: String
    let glass: String
    let instructions: String
    let thumbNailUrl: URL
    let dateModified: Date?
    var thumbImage: UIImage?
}

extension Cocktail: Comparable {
    /// Compares cocktails for sorting.
    /// - Parameters:
    ///   - lhs: value at the left side.
    ///   - rhs: value at the right side.
    /// - Returns: true if the left value is lower  than the right value and false for the opposite.
    static func < (lhs: Cocktail, rhs: Cocktail) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: String, rhs: Cocktail) -> Bool {
        if lhs == rhs.alcoholic ||
            lhs == rhs.category ||
            lhs == rhs.glass {
            return true
        }
        return false
    }
}

extension Cocktail: Decodable {
    enum CodingKeys: String, CodingKey {
        case id           = "idDrink"
        case name         = "strDrink"
        case category     = "strCategory"
        case alcoholic    = "strAlcoholic"
        case glass        = "strGlass"
        case instructions = "strInstructions"
        case thumbNailUrl = "strDrinkThumb"
        case dateModified
    }
}


