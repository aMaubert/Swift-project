//
//  Address.swift
//  project
//
//  Created by allan on 01/07/2020.
//  Copyright © 2020 allan. All rights reserved.
//

struct Address : Codable {
    
    var id: UInt64? = nil
    var propertyNumber: String
    var streetName: String
    var postalCode: Int
    var city: String
    var country: String
    var latitude: Double? = nil
    var longitude: Double? = nil
    
}

