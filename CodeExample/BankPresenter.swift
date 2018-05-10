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
        // Note: Here I take our raw data from our response and convert
        // it to applicable view models
        let transactionViewModels: [TransationTableViewCell.TransationViewModel] = bankData.transactions.map {
            let sentReceivedText = sentOrReceivedText(result: $0.result)
            let btcValue = btcValueConversion(result: $0.result)
            let amountText = formatAmountText(sentReceivedText: sentReceivedText, btcValue: btcValue)
            return TransationTableViewCell.TransationViewModel(amountText: amountText, timeText: $0.time.displayString())
        }
        let bankViewModel = BankViewController.BankViewModel(transactions: transactionViewModels)
        viewInput?.set(viewModel: bankViewModel)
    }
    
    func sentOrReceivedText(result: Double) -> String {
        return result > 0 ? "Received" : "Sent"
    }
    
    func btcValueConversion(result: Double) -> Double {
        return result / 100000000
    }
    
    func formatAmountText(sentReceivedText: String, btcValue: Double) -> String {
        return "\(sentReceivedText): \(abs(btcValue)) BTC"
    }
}
