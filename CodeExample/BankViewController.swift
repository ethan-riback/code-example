//
//  BankViewController.swift
//  CodeExample
//
//  Created by Ethan Riback on 5/7/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

import UIKit

protocol BankViewInput: class {
    func set(bankData: Bank)
}

protocol BankViewOutput {
    func fetchData()
}

class BankViewController: UITableViewController {
    
    var output: BankViewOutput?
    
    // Create default Bank init so that I can make this lazy and non-optional
    private var bankData: Bank? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BankRouter().start(with: self)
        output?.fetchData()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? TransationTableViewCell,
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

extension BankViewController: BankViewInput {
    func set(bankData: Bank) {
        self.bankData = bankData
        
        DispatchQueue.main.sync {
            tableView.reloadData()
        }
    }
}
