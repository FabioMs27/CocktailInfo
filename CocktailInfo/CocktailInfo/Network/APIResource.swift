//
//  APIResource.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 05/02/21.
//

import Foundation

/// Resource used by the Api request to determine the url used and model type.
protocol APIResource {
    associatedtype ModelType: Decodable
    var url: URL? { get set }
}
/// Conforms to APIResource and contains the model and url related to the venues.
struct Resource<T: Decodable>: APIResource {
    typealias ModelType = T
    var url: URL?
}
