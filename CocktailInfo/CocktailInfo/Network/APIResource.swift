//
//  APIResource.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 05/02/21.
//

import Foundation

/// Generic api resource containing the type and information for performing an api request./
protocol APIResource {
    associatedtype ModelType: Decodable
    var url: URL? { get }
    var methodPath: String { get }
    var key: String { get }
    var queryValue: String? { get }
}

/// Contains information to request cocktails.
struct CocktailResource: APIResource {
    typealias ModelType = Cocktail
    var url: URL? {
        return URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(queryValue ?? "a")")
    }
    let methodPath = "/search.php"
    let key = "/1"
    var queryValue: String?
}
