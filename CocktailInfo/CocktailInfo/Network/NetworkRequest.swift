//
//  NetworkRequest.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 05/02/21.
//

import Foundation

/// Used to fetch data from a url and parse it into swift data.
protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func load(withCompletion completion: @escaping (Result<ModelType, NetworkError>) -> ())
}

extension NetworkRequest {
    /// Loads data from given url and returns a model type or an error.
    /// - Parameters:
    ///   - url: The api host with it's path and query information.
    ///   - completion: A closure carrying the parsed model type or a error as parameter.
    /// - Returns: A result enumeration containing either a model type or a network error.
    fileprivate func load(_ url: URL?, withCompletion completion: @escaping (Result<ModelType, NetworkError>) -> ()) {
        DispatchQueue.global(qos: .background).async {
            
            guard let url = url else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidURL))
                }
                return
            }
            
            let config = URLSessionConfiguration.default
            config.waitsForConnectivity = true
            config.timeoutIntervalForResource = 100
            let session = URLSession(configuration: config)
            
            session.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    DispatchQueue.main.async {
                        completion(.failure(.offline))
                    }
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    DispatchQueue.main.async {
                        completion(.failure(.connectionError))
                    }
                    return
                }
                
                guard let mime = response?.mimeType, mime == "application/json" else {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidResponseType))
                    }
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard
                        let data = data,
                        let object: ModelType = self?.decode(data) else {
                        completion(.failure(.objectNotDecoded))
                        return
                    }
                    
                    completion(.success(object))
                }
                
            }.resume()
        }
    }
}

/// Recieves a resource containing the url and model type and perform api related requests.
class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    /// Decodes data into model type.
    /// - Parameter data: The data recieved from the url.
    /// - Returns: Parsed data into a model type.
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        
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
