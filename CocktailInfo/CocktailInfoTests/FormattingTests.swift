//
//  FormattingTests.swift
//  CocktailInfoTests
//
//  Created by Fábio Maciel de Sousa on 08/02/21.
//

import XCTest
@testable import CocktailInfo

class FormattingTests: XCTestCase {

    func testStringFormatting() {
        let search = " Margarita Blue   "
        let sut = search.formatted
        XCTAssertEqual(sut, "margaritablue")
    }
    
    func testDateFormatting() {
        let formatter: DateFormatter = .customFormat
        let sut = formatter.date(from: "2015-08-18 14:42:59")
        XCTAssertNotNil(sut)
        guard let date = sut else {
            fatalError("Formatter not working")
        }
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        XCTAssertEqual(year, 2015)
        XCTAssertEqual(month, 08)
        XCTAssertEqual(day, 18)
        XCTAssertEqual(hour, 14)
        XCTAssertEqual(minute, 42)
        XCTAssertEqual(second, 59)
    }
    
}
