//
//  Bank.swift
//  CodeExample
//
//  Created by Ethan Riback on 5/8/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

import Foundation

// I was not entirely sure what to name this but I felt "Bank" was appropriate
struct Bank: Decodable {
    
    let finalBalance: Double
    let transactions: [Transaction]
    
    private enum CodingKeys: String, CodingKey {
        case wallet
        case finalBalance = "final_balance"
        case transactions = "txs"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let wallet = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .wallet)
        finalBalance = try wallet.decode(Double.self, forKey: .finalBalance)
        transactions = try values.decode([Transaction].self, forKey: .transactions)
    }
}
