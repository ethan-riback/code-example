//
//  TransationTableViewCell.swift
//  CodeExample
//
//  Created by Ethan Riback on 5/8/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

import UIKit

class TransationTableViewCell: UITableViewCell {
    
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    struct TransationViewModel {
        let amountText: String
        let timeText: String
    }
   
    // Note: I like to use "Apply" methods to deal with view models
    // and applying them to views
    func apply(viewModel: TransationViewModel) {
        amountLabel.text = viewModel.amountText
        timeLabel.text = viewModel.timeText
    }
    
}
