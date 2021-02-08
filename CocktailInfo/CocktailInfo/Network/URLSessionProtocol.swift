//
//  URLSessionProtocol.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 08/02/21.
//

import Foundation

protocol URLSessionProtocol: URLSession {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    func dataTaskWithURL(_ url: URL, completionHandler: @escaping DataTaskResult)
    -> URLSessionDataTaskProtocol {
        dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

class MockedURLDataTask: URLSessionDataTaskProtocol {
    func resume() {}
}

class MockedURLSession: URLSession {
    
    var dataTaskProtocol = MockedURLDataTask()
    
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        if let data = try? Data(contentsOf: url) {
            completionHandler(data, nil, nil)
        }
        let httpResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        completionHandler(nil, httpResponse, nil)
        return dataTaskProtocol
    }
}
