//
//  Formatter.swift
//  project
//
//  Created by allan on 10/07/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct Formatter {
    
    private static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
    
    public static func formatDouble(_ number: Double) -> String {
        if let formatted = Formatter.withSeparator.string(from: number as NSNumber) {
            return formatted
        }
        return String(format: "%.2f", number)
   }

}
