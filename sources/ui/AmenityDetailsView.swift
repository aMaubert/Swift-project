//
//  AmenityDetailsView.swift
//  project
//
//  Created by allan on 18/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct AmenityDetailsView: View {
    
    @State private var propertyId: UInt64? = nil
    var amenity: Amenity
    
    var body: some View {
        VStack(alignment: .leading) {
             Spacer()
            Text(" type de service : \(self.amenity.type)")
            Spacer()
            Text(" Ville : \(self.amenity.address.city)")
            Text(" Pays : \(self.amenity.address.country)")
            Text(" Address  : \(self.amenity.address.propertyNumber  + " " + self.amenity.address.streetName ) ")
            Text(" Code postal : \(String(self.amenity.address.postalCode))")
            Spacer()
            MapView(propertyId: $propertyId, propertyCheckpoint: self.amenityCheckpoint())
            
        }.navigationBarTitle(self.amenity.name)
    }
    
    func amenityCheckpoint() -> Checkpoint? {
      if let latitude = self.amenity.address.latitude,
          let longitude = self.amenity.address.longitude {
        return Checkpoint(title: self.amenity.name, coordinate: .init(latitude: latitude, longitude: longitude))
      }
      return nil
    }
    
}

struct AmenityDetailsView_Previews: PreviewProvider {
    static var amenity = Amenity(type: "test", name: "Test", address: Address(propertyNumber: "11A", streetName: "rue test", postalCode: 75002, city: "Paris", country: "France"))
    static var previews: some View {
        AmenityDetailsView(amenity: amenity)
    }
}
