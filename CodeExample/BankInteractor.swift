//
//  BankInteractor.swift
//  CodeExample
//
//  Created by Ethan Riback on 5/8/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

import Foundation

protocol BankInteractorInput: class {
    func fetchData()
}

protocol BankInteractorOutput: class {
    func returnBankData(_ bankData: Bank)
}

class BankInteractor {
    
    weak var output: BankInteractorOutput?
}

extension BankInteractor: BankInteractorInput {
    func fetchData() {
        // I normally prefer using Web frameworks to make requests since URLSession usually produces not the most readible code
        let urlString = "https://blockchain.info/multiaddr?active=xpub6CfLQa8fLgtouvLxrb8EtvjbXfoC1yqzH6YbTJw4dP7srt523AhcMV8Uh4K3TWSHz9oDWmn9MuJogzdGU3ncxkBsAC9wFBLmFrWT9Ek81kQ"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(Bank.self, from: data)
                self?.output?.returnBankData(data)
            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
}
