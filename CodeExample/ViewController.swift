//
//  ViewController.swift
//  CodeExample
//
//  Created by Ethan Riback on 5/7/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

import UIKit

struct Transaction: Decodable {
    // Keep data model with Satoshi's, convert to BTC when creating View Model
    let result: Double
    let time: Date
    //let out: Other field to define that I do not quite understand, pull this when I know what it's needed for
    let hash: String
    let fee: Double
}

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

class ViewController: UIViewController {
    
    // Create default Bank init so that I can make this lazy and non-optional
    private let bankData: Bank? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    func fetchData() {
        // I normally prefer using Web frameworks to make requests since URLSession usually produces not the most readible code
        let urlString = "https://blockchain.info/multiaddr?active=xpub6CfLQa8fLgtouvLxrb8EtvjbXfoC1yqzH6YbTJw4dP7srt523AhcMV8Uh4K3TWSHz9oDWmn9MuJogzdGU3ncxkBsAC9wFBLmFrWT9Ek81kQ"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(Bank.self, from: data)
                print(data)
            } catch let err {
                print("Err", err)
            }
        }.resume()
    }


}

