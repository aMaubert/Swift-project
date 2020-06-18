//
//  properties.swift
//  project
//
//  Created by allan on 17/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct propertiesView: View {
    var body: some View {
        
        NavigationView {
            List{
                NavigationLink(destination: propertyDetails()) {
                    propertyRow()
                }
                NavigationLink(destination: propertyDetails()) {
                    propertyRow()
                }
                
            }.navigationBarTitle("List des Propriétés")
            .navigationBarItems( trailing:
                HStack{
                    Text("Add")
                }
            )
        }
    }
}


struct propertyRow: View {
    
    var body: some View {
        Text("Row of property here")
    }
}



struct propertyDetails: View {
    
    var body: some View {
        Text("Details of property here")
    }
}


struct properties_Previews: PreviewProvider {
    static var previews: some View {
        propertiesView()
    }
}
