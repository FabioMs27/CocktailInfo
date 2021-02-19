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
        let request = MockedRequest(resource: CocktailResource())
        let expectation = XCTestExpectation(description: "Expectation")
        
        request.load { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDecodingFailure() {
        let expectation = XCTestExpectation(description: "Expectation")
        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita")
        let resource = MockedResource<Cocktail>(url: url)
        let request = MockedRequest(resource: resource)
        request.load { result in
            switch result {
            case .success: break
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, NetworkError.objectNotDecoded.localizedDescription)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
