//
//  PropertyService.swift
//  project
//
//  Created by allan on 01/07/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI


struct PropertyService {
    private let baseUri = "http://localhost:8080/properties"
    
    public func getAmenityInRange(id: UInt64, distance: UInt) {
        
        //Get a session
        let session = URLSession.shared
        
        guard let url = URL(string: "\(self.baseUri)/\(id)/amenities?distance=\(distance)") else {
            return;
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            //Manage the result
            guard error == nil else { return }
            guard let data = data else { return }
            
            print(data)
        }
        
        task.resume()
        
    }
}
