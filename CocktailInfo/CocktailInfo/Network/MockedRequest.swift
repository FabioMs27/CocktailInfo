//
//  MockedRequest.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 08/02/21.
//

import Foundation

/// Recieves a resource containing the url and model type and perform api related requests.
class MockedRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension MockedRequest: NetworkRequest {
    
    var session: URLSessionProtocol { MockedURLSession.shared }
    
    /// Decodes data into model type.
    /// - Parameter data: The data recieved from the url.
    /// - Returns: Parsed data into a model type.
    
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormat)
        
        guard let object = try? decoder.decode(ModelType.self, from: data) else { return nil }
        return object
    }
    
    /// Loads data from given api and returns a model type or an error.
    /// - Parameter completion: A closure carrying the parsed model type or a error as parameter.
    /// - Returns: A result enumeration containing either a model type or a network error.
    func load(withCompletion completion: @escaping (Result<Resource.ModelType, NetworkError>) -> ()) {
        load(resource.url, withCompletion: completion)
    }
}

struct MockedResource<T: Decodable>: APIResource {
    typealias ModelType = T
    var url: URL?
    var methodPath: String = ""
    var key: String = ""
    var queryValue: String?
}
