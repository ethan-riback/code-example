//
//  BankPresenterTests.swift
//  CodeExampleTests
//
//  Created by Ethan Riback on 5/10/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

import XCTest
@testable import CodeExample

class BankPresenterTests: XCTestCase {
    
    var presenter: BankPresenter!
    private var mockViewInput: MockBankViewInput!
    private var mockInteractorInput: MockBankInteractorInput!
    
    override func setUp() {
        super.setUp()
        mockViewInput = MockBankViewInput()
        mockInteractorInput = MockBankInteractorInput()
        presenter = BankPresenter()
        presenter.viewInput = mockViewInput
        presenter.interactorInput = mockInteractorInput
    }

    func testThatFetchDataWorks() {
        presenter.fetchData()
        XCTAssertTrue(mockInteractorInput.fetchDataWasCalled, "Data is not being fetched as expected")
    }
    
    func testThatReturnBankDataWorks() {
        let mockData = Bank()
        presenter.returnBankData(mockData)
        XCTAssertTrue(mockViewInput.setViewModelWasCalled, "Data is not returned as expected")
    }
    
    func testThatSentOrReceivedText() {
        XCTAssertEqual(presenter.sentOrReceivedText(result: 10.0), "Received", "Returned text is incorrect for positive value")
        XCTAssertEqual(presenter.sentOrReceivedText(result: -10.0), "Sent", "Returned text is incorrect for negative value")
    }
    
    func testThatBTCValueConversionIsCorrect() {
        XCTAssertEqual(presenter.btcValueConversion(result: 100000000), 1, "btcValueConversion is incorrect")
    }
    
    func testThatFormatTextIsCorrect() {
        XCTAssertEqual(presenter.formatAmountText(sentReceivedText: "Test Positive", btcValue: 10.0),
                       "Test Positive: 10.0 BTC",
                       "Text Format is incorrect for positive value")
        XCTAssertEqual(presenter.formatAmountText(sentReceivedText: "Test Negative", btcValue: -10.0),
                       "Test Negative: 10.0 BTC",
                       "Text Format is incorrect for negative value")
    }
}

private class MockBankViewInput: BankViewInput {
    var setViewModelWasCalled = false
    func set(viewModel: BankViewController.BankViewModel) {
        setViewModelWasCalled = true
    }
}

private class MockBankInteractorInput: BankInteractorInput {
    var fetchDataWasCalled = false
    func fetchData() {
        fetchDataWasCalled = true
    }
}
