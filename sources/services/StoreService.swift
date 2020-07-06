//
//  StoreService.swift
//  project
//
//  Created by allan on 02/07/2020.
//  Copyright © 2020 allan. All rights reserved.
//


struct StoreService {
    
    private static var storage = Dictionary<String, String>()
    
    
    public static func set(key: String, value: String?) {
        storage[key] = value
    }
    
    public static func get(key: String) -> String? {
        return storage[key]
    }
    
}
