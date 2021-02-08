//
//  NetworkRequestTests.swift
//  CocktailInfoTests
//
//  Created by Fábio Maciel de Sousa on 08/02/21.
//

import XCTest
@testable import CocktailInfo

class NetworkRequestTests: XCTestCase {
    
    let fileName = "cocktail"

    func testSuccessfulApiRequestResponse() {
        let request = MockedRequest(resource: DrinksResource())
        let expectation = XCTestExpectation(description: "Expectation")
        
        request.load { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let error): fatalError(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
}
