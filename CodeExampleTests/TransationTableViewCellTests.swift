//
//  TransationTableViewCellTests.swift
//  CodeExampleTests
//
//  Created by Ethan Riback on 5/10/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

import XCTest
@testable import CodeExample

class TransationTableViewCellTests: XCTestCase {
    
    var cell: TransationTableViewCell!
    
    override func setUp() {
        super.setUp()
        cell = TransationTableViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        cell.amountLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        cell.timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    func testThatApplyIsWorking() {
        cell.apply(viewModel: TransationTableViewCell.TransationViewModel(amountText: "Amount Mock", timeText: "Time Mock"))
        XCTAssertEqual(cell.amountLabel.text, "Amount Mock", "Amount Label did not have its text set properly")
        XCTAssertEqual(cell.timeLabel.text, "Time Mock", "Time Label did not have its text set properly")
    }

}
