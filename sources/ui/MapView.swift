//
//  MapView.swift
//  project
//
//  Created by allan on 24/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    
    @State var checkpoints = Array<Checkpoint>()
    @Binding var propertyId: UInt64
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    func updateUIView(_ uiView: MKMapView,
                      context: Context) {
        self.getAmenityInRange(id: self.propertyId, distance: 20, uiView: uiView)
    }
    
    
    
    public func getAmenityInRange(id: UInt64, distance: UInt, uiView: MKMapView) {
        
        let baseUri = "http://localhost:8080/properties"
        let bearerToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJST0xFX0FkbWluLFJPTEVfVXNlciIsImV4cCI6MTU5MzY0NzY3OH0.V4llhsyLs_uTduMMHBos8GeFAlf3uZ3_WLo9yt8YUxA"
        
        //Get a session
        let session = URLSession.shared
        
        guard let url = URL(string: "\(baseUri)/\(id)/amenities?distance=\(distance)") else {
            return;
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(bearerToken, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 2000000.0
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            //Manage the result
            guard error == nil else { return }
            guard let data = data else { return }
            
            print(String(data: data, encoding: .utf8)!)
            
            if let amenities = self.decodeAmenity(from: data) {
                print(amenities[0].address)
                for amenity in amenities {
                    if let latitude = amenity.address.latitude, let longitude =  amenity.address.longitude {
                        let checkpoint = Checkpoint(title: amenity.name, coordinate: .init(latitude: latitude,longitude:longitude))
                        self.checkpoints.append(checkpoint)
                    }
                   
                }
                
                DispatchQueue.main.async {
                    uiView.addAnnotations(self.checkpoints)
                }
                
            }
        }
        task.resume()
    }
    
    private func decodeAmenity(from data: Data) -> [Amenity]? {

        let decoder = JSONDecoder()
        let amenities = try? decoder.decode([Amenity].self, from: data)
        return amenities
    }
    
}

struct MapView_Previews: PreviewProvider {
    @State static var id: UInt64 = 8

    static var previews: some View {
        MapView(propertyId: $id)
    }
}
