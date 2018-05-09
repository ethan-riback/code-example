//
//  BankPresenter.swift
//  CodeExample
//
//  Created by Ethan Riback on 5/8/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

class BankPresenter {
    
    weak var viewInput: BankViewInput?
    var interactorInput: BankInteractorInput?
}

extension BankPresenter: BankViewOutput {
    func fetchData() {
        interactorInput?.fetchData()
    }
}

extension BankPresenter: BankInteractorOutput {
    func returnBankData(_ bankData: Bank) {
        viewInput?.set(bankData: bankData)
    }
}
