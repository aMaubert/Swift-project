//
//  AmenityService.swift
//  project
//
//  Created by allan on 02/07/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct AmenityService {
    
    public static func baseUri() -> String {
        if let baseUri = StoreService.get(key: "API_BASE_URL") {
            return "\(baseUri)/amenities"
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
    
    public static func decodeAmenities(from data: Data) -> [Amenity]? {
        let decoder = JSONDecoder()
        let amenities = try? decoder.decode([Amenity].self, from: data)
        return amenities
    }
    
    public static func encodeAmenity(amenity: Amenity) -> Data? {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(amenity)
        return data
    }

}
