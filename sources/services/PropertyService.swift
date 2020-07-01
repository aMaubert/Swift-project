//
//  PropertyService.swift
//  project
//
//  Created by allan on 01/07/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI


struct PropertyService {
    
    public static let baseUri = "http://localhost:8080/properties"
    
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

}
