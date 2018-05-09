//
//  Transaction.swift
//  CodeExample
//
//  Created by Ethan Riback on 5/8/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

import Foundation

struct Transaction: Decodable {
    // Keep data model with Satoshi's, convert to BTC when creating View Model
    let result: Double
    let time: Date
    //let out: Other field to define that I do not quite understand, pull this when I know what it's needed for
    let hash: String
    let fee: Double
}
