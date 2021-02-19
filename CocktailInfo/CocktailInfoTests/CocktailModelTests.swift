//
//  CocktailDecoding.swift
//  CocktailInfoTests
//
//  Created by Fábio Maciel de Sousa on 08/02/21.
//

import XCTest
@testable import CocktailInfo

class CocktailModelTests: XCTestCase {
    
    let fileName = "cocktail"
    
    func testCocktailDecoding() {
        guard let url = Bundle(for: CocktailModelTests.self).url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Couldn't locate file")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.customFormat)
        guard let list = try? decoder.decode(Wrapper<Cocktail>.self, from: data),
              let sut = list.items?.first else {
            fatalError("Couldn't decode")
        }
        
        let formatter: DateFormatter = .customFormat
        let testDate = formatter.date(from: "2015-08-18 14:42:59")
        
        XCTAssertEqual(sut.name, "Margarita")
        XCTAssertEqual(sut.category, "Ordinary Drink")
        XCTAssertEqual(sut.alcoholic, "Alcoholic")
        XCTAssertEqual(sut.glass, "Cocktail glass")
        XCTAssertEqual(sut.id, "11007")
        XCTAssertEqual(sut.instructions, "Rub the rim of the glass with the lime slice to make the salt stick to it. Take care to moisten only the outer rim and sprinkle the salt on it. The salt should present to the lips of the imbiber and never mix into the cocktail. Shake the other ingredients with ice, then carefully pour into the glass.")
        XCTAssertEqual(sut.thumbNailUrl.absoluteString, "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg")
        XCTAssertEqual(sut.dateModified, testDate)
    }
    
    func testSortingCocktail() {
        var sut = [Cocktail]()
        let options = ["C", "B", "A"]
        options.forEach { letter in
            sut.append(Cocktail(id: "", name: letter, category: "", alcoholic: "", glass: "", instructions: "", thumbNailUrl: URL(string: "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg")!, dateModified: nil))
        }
        sut = sut.sorted(by: <)
        XCTAssertTrue(sut.first!.name == "A")
        XCTAssertTrue(sut[1].name == "B")
        XCTAssertTrue(sut.last!.name == "C")
    }
    
}
