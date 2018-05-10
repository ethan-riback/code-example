//
//  BankViewControllerTests.swift
//  CodeExampleTests
//
//  Created by Ethan Riback on 5/10/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

import XCTest
@testable import CodeExample

class BankViewControllerTests: XCTestCase {
    
    private var view: MockBankViewController!
    private var mockViewOutput: MockBankViewOutput!
    
    override func setUp() {
        super.setUp()
        view = MockBankViewController(style: .plain)
        mockViewOutput = MockBankViewOutput()
        view.output = mockViewOutput
        let mockTransactions = [
            TransationTableViewCell.TransationViewModel(amountText: "Amount One", timeText: "Time One"),
            TransationTableViewCell.TransationViewModel(amountText: "Amount Two", timeText: "Time Two"),
            TransationTableViewCell.TransationViewModel(amountText: "Amount Three", timeText: "Time Three")
        ]
        let mockViewModel = BankViewController.BankViewModel(transactions: mockTransactions)
        view.set(viewModel: mockViewModel)
    }
    
    func testThatViewSetupIsCorrect() {
        let mockRouter = MockBankRouter()
        view.setup(router: mockRouter)
        XCTAssertTrue(mockRouter.startWasCalled, "Router was not called to set up the view")
        XCTAssertTrue(mockViewOutput.fetchDataWasCalled, "output was not called to fetch data for the view")
    }
    
    func testThatSetViewModelWorked() {
        XCTAssertEqual(view.viewModel.transactions.count, 3, "View's view model was not properly set!")
        XCTAssertTrue(view.reloadTableViewDataWasCalled)
    }
    
    // NOTE: I normally would test animations but they can sometimes be a bit tricky. For time's sake I'll skip over this.
    
    func testThatTableViewNumberOfSectionsIsCorrect() {
        XCTAssertEqual(view.numberOfSections(in: UITableView()), 1, "There should only be one section in the view's tableView")
    }
    
    func testThatNumberOfRowsInTableViewIsCorrect() {
        XCTAssertEqual(view.tableView(UITableView(), numberOfRowsInSection: 0), 3, "The amount of items in the table view is not the expected value.")
    }
}

private class MockBankViewController: BankViewController {
    var reloadTableViewDataWasCalled = false
    override func reloadTableViewData() {
        reloadTableViewDataWasCalled = true
    }
}

private class MockBankViewOutput: BankViewOutput {
    var fetchDataWasCalled = false
    func fetchData() {
        fetchDataWasCalled = true
    }
}

private class MockBankRouter: BankRouter {
    var startWasCalled = false
    override func start(with view: BankViewController) {
        startWasCalled = true
    }
}
