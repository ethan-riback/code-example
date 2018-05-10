//
//  BankViewController.swift
//  CodeExample
//
//  Created by Ethan Riback on 5/7/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

import UIKit

// Note: I make effective use of protocols to keep class responsibility separated,
// this way, if we need a view redesign driven by the same data, only this class
// needs to change but other classes stay the same.
protocol BankViewInput: class {
    func set(viewModel: BankViewController.BankViewModel)
}

// Note: I have lately enjoyed adding complete swift standard documentation
// to my protocols. I didn't in this cause I need to catch a flight. Might
// update later...
protocol BankViewOutput {
    func fetchData()
}

class BankViewController: UITableViewController {
    
    // Note: With a view model, I am keeping this class as dumb as possible
    struct BankViewModel {
        let transactions: [TransationTableViewCell.TransationViewModel]
    }
    
    var output: BankViewOutput?
    
    // Note: I like to use private(set) since it's easy for unit testing
    private(set) var viewModel: BankViewModel = BankViewModel(transactions: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(router: BankRouter())
    }
    
    // Note: I separated some of this code out to make some unit testing easier.
    // Plus, it's also easier to read now!
    func setup(router: BankRouter) {
        router.start(with: self)
        output?.fetchData()
    }
    
    func reloadTableViewData() {
        DispatchQueue.main.sync {
            tableView.reloadData()
        }
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
        return viewModel.transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? TransationTableViewCell else {
            return UITableViewCell()
        }
        
        let transaction = viewModel.transactions[indexPath.item]
        cell.amountLabel.text = transaction.amountText
        cell.timeLabel.text = transaction.timeText
        
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
    func set(viewModel: BankViewController.BankViewModel) {
        self.viewModel = viewModel
        reloadTableViewData()
    }
}
