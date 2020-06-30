//
//  Property.swift
//  project
//
//  Created by allan on 30/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//


struct Property {
    enum TransactionType : String, CaseIterable, Identifiable {
        case SALE, LEASING
        
        var id: TransactionType {
            return self
        }
    }
}
