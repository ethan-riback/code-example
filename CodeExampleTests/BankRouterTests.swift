//
//  BankRouterTests.swift
//  CodeExampleTests
//
//  Created by Ethan Riback on 5/10/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

import XCTest
@testable import CodeExample

class BankRouterTests: XCTestCase {
    
    var view: BankViewController!
    
    override func setUp() {
        super.setUp()
        view = BankViewController(style: .plain)
        BankRouter().start(with: view)
    }
    
    func testThatVIPRWasSet() {
        let presenter = view.output as? BankPresenter
        let interactor = presenter?.interactorInput as? BankInteractor
        XCTAssertNotNil(view.output, "BankViewOutput was not properly set in the view")
        XCTAssertNotNil(presenter?.viewInput, "BankViewInput was not properly set in the presenter")
        XCTAssertNotNil(presenter?.interactorInput, "BankInteractorInput was not properly set in the presenter")
        XCTAssertNotNil(interactor?.output, "BankInteractorOutput was not properly set in the interactor")
    }

}
