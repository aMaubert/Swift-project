//
//  AmenityListView.swift
//  project
//
//  Created by allan on 18/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct AmenityListView: View {
    var body: some View {
        NavigationView {
            List{
                NavigationLink(destination: AmenityDetailsView()) {
                    AmenityRow()
                }
                NavigationLink(destination: AmenityDetailsView()) {
                    AmenityRow()
                }
                
            }.navigationBarTitle("List des Amenities")
            .navigationBarItems( trailing:
                HStack{
                    Text("Add")
                }
            )
        }
    }
}


struct AmenityRow: View {
    var body: some View {
        Text("Amenity Row")
    }
}

struct AmenityListView_Previews: PreviewProvider {
    static var previews: some View {
        AmenityListView()
    }
}
