//
//  Category.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 21/02/21.
//

import Foundation

struct Categories {
    let category: String
}

extension Categories: Decodable {
    enum CodingKeys: String, CodingKey {
        case category = "strCategory"
    }
}

extension Categories: Comparable {
    /// Compares cocktails for sorting.
    /// - Parameters:
    ///   - lhs: value at the left side.
    ///   - rhs: value at the right side.
    /// - Returns: true if the left value is lower  than the right value and false for the opposite.
    static func < (lhs: Categories, rhs: Categories) -> Bool {
        return lhs.category < rhs.category
    }
}

/// Wrapper containing all the cocktail drinks.
struct Wrapper<T: Decodable> {
    let items: [T]?
}

extension Wrapper: Decodable {
    enum CodingKeys: String, CodingKey {
        case items = "drinks"
    }
}
