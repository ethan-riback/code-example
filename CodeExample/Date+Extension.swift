//
//  Date+Extension.swift
//  CodeExample
//
//  Created by Ethan Riback on 5/8/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

import Foundation

// Note: Instead of keeping this method alone in a view controller, it could be useful
// across the app, so I add it as a method to Date class
extension Date {
    func displayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter.string(from: self)
    }
}
