//
//  BankViewController.swift
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

class BankViewController: UITableViewController {
    
    // Create default Bank init so that I can make this lazy and non-optional
    private var bankData: Bank? = nil
    
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
                // TODO: weak self
                self.bankData = data
                self.tableView.reloadData()
            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
    
    // MARK: Cell Animations
    @objc func amountLabelTapped(_ sender: UITapGestureRecognizer) {
        
        // This does not work very well with UILabels but I felt it was work including as a second example
        // Shrink Animation
        UIView.animate(withDuration: 1, animations: {
            if let frame = sender.view?.frame {
                let newFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width / 2, height: frame.height)
                sender.view?.frame = newFrame
            }
        })
    }
    
    @objc func timeLabelTapped(_ sender: UITapGestureRecognizer) {
        
        // Rotation Animation
        UIView.animate(withDuration: 1, animations: {
            if let rotation = sender.view?.transform.rotated(by: CGFloat.pi) {
                sender.view?.transform = rotation
            }
        })
    }
    
    // MARK: Datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankData?.transactions.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? BankTableViewCell,
            let transaction = bankData?.transactions[indexPath.item] else {
                return UITableViewCell()
        }
        
        cell.amountLabel.text = "Sent \(transaction.result)"
        cell.timeLabel.text = transaction.time.displayString()
        
        let amountLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.amountLabelTapped(_:)))
        cell.amountLabel.addGestureRecognizer(amountLabelTap)
        cell.amountLabel.isUserInteractionEnabled = true
        
        let timeLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.timeLabelTapped(_:)))
        cell.timeLabel.addGestureRecognizer(timeLabelTap)
        cell.timeLabel.isUserInteractionEnabled = true
        
        return cell
    }
}
