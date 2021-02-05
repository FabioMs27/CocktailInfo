//
//  NetworkError.swift
//  CocktailInfo
//
//  Created by Fábio Maciel de Sousa on 05/02/21.
//

import Foundation

/// Enum containing the errors that can occur on the app related to network.
enum NetworkError: Error {
    case offline
    case unknownError
    case invalidResponseType
    case objectNotDecoded
    case connectionError
    case invalidURL
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .offline: return "The device is not connected to the internet."
        case .unknownError: return "Unknown connection error."
        case .invalidResponseType: return "The returned data type is invalid."
        case .objectNotDecoded: return "The returned object couldn't be decoded."
        case .connectionError: return "Connection error."
        case .invalidURL: return "The Url provided is invalid."
        }
    }
}
