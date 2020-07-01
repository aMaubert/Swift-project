//
//  Property.swift
//  project
//
//  Created by allan on 30/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//


struct Property {
    
    var id: UInt64?
    var price: Double
    var surface: Double
    var rooms: Double
    var address: Address
    var isAvailable: Bool
    var purchaser: User?
    
    enum TransactionType : String, CaseIterable, Identifiable {
        case SALE, LEASING
        
        var id: TransactionType {
            return self
        }
    }
}
