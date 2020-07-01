//
//  Account.swift
//  project
//
//  Created by allan on 01/07/2020.
//  Copyright © 2020 allan. All rights reserved.
//

struct Account : Codable {
    var id: UInt64?
    var login: String
    var password: String
    var isAdmin: Bool
    var isActivated: Bool = false
}


