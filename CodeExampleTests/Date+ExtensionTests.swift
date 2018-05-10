//
//  Date+ExtensionTests.swift
//  CodeExampleTests
//
//  Created by Ethan Riback on 5/10/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

import XCTest
@testable import CodeExample

class DateExtensionTests: XCTestCase {
    func testThatDateDisplayStringIsCorrect() {
        let date = Date(timeIntervalSince1970: 89723405)
        XCTAssertEqual(date.displayString(), "Nov 4, 1972 at 6:10:05 AM")
    }
}
