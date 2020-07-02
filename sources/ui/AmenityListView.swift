//
//  AmenityListView.swift
//  project
//
//  Created by allan on 18/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct AmenityListView: View {
        
    @State private var amenities = [Amenity]()
    
    var body: some View {
        NavigationView {
            List(self.amenities){ amenity in
                NavigationLink(destination: AmenityDetailsView(amenity: amenity)) {
                    AmenityRow(amenity: amenity)
                }
            }.navigationBarTitle("List des Amenities")
                .navigationBarItems( trailing:
                    HStack{
                        Text("Add")
                    }
                )
        }.onAppear {
            self.getAllAmenities()
        }
    }
    
    func getAllAmenities() {
        guard let bearerToken = StoreService.get(key: "TOKEN") else { return }
        
        //Get a session
        let session = URLSession.shared
        
        guard let url = URL(string: AmenityService.baseUri() ) else {
            return;
        }
        
        let request = AmenityService.makeUrlRequest(url:url, httpMethod: "GET", bearerToken: bearerToken)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else { return }
            guard let data = data else {
                return
            }
                    
            if let amenities = AmenityService.decodeAmenities(from: data) {
               DispatchQueue.main.async {
                   self.amenities = amenities
               }
           }
        }
        task.resume()
    }
    
}

struct AmenityRow: View {
    var amenity: Amenity
    var body: some View {
        VStack(alignment: .leading) {
            Text("nom : \(self.amenity.name)")
            Text("type : \(self.amenity.type)")
        }
    }
}

struct AmenityListView_Previews: PreviewProvider {
    static var previews: some View {
        AmenityListView()
    }
}
