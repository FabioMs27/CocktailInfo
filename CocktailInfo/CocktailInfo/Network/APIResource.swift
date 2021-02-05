//
//  APIResource.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 05/02/21.
//

import Foundation

protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
    var key: String { get }
    var queryValue: String? { get }
}

extension APIResource {
//    var url: URL? {
//        var components = URLComponents(string: "https://www.thecocktaildb.com/api/json/v1\(key)")
//        components?.path = methodPath
//        components?.queryItems = [
//            URLQueryItem(name: "s", value: queryValue ?? "a"),
//        ]
//        return components?.url
//    }
    
    var url: URL? {
        return URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(queryValue ?? "a")")
    }
}

struct DrinksResource: APIResource {
    typealias ModelType = Drinks
    let methodPath = "/search.php"
    let key = "/1"
    var queryValue: String?
}
