//
//  Transaction.swift
//  CodeExample
//
//  Created by Ethan Riback on 5/8/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

import Foundation

struct Transaction: Decodable {
    let result: Double
    let time: Date
    let hash: String
    let fee: Double
}
