//
//  PropertyService.swift
//  project
//
//  Created by allan on 01/07/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct PropertyService {
    
    public static func baseUri() -> String {
        if let baseUri = StoreService.get(key: "API_BASE_URL") {
            return "\(baseUri)/properties"
        }
        return ""
    }
    
    
    public static func makeUrlRequest(url: URL, httpMethod: String, bearerToken: String) -> URLRequest {
         var request = URLRequest(url: url)
         request.httpMethod = httpMethod
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         request.addValue("application/json", forHTTPHeaderField: "Accept")
         request.addValue(bearerToken, forHTTPHeaderField: "Authorization")
         request.timeoutInterval = 2000000.0
        
         return request
    }
    
    public static func decodeProperties(from data: Data) -> [Property]? {

        let decoder = JSONDecoder()
        let properties = try? decoder.decode([Property].self, from: data)
        return properties
    }
    
    
    public static func decodeProperty(from data: Data) -> Property? {
        let decoder = JSONDecoder()
        let property = try? decoder.decode(Property.self, from: data)
        return property
    }

    public static func encodeProperty(property: Property) -> Data? {

        let encoder = JSONEncoder()
        let data = try? encoder.encode(property)
        return data
    }

}
