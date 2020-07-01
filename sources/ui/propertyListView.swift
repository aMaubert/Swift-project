//
//  properties.swift
//  project
//
//  Created by allan on 17/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct propertyListView: View {
    
    @State private var isAddingProperty = false
    
    var body: some View {
        
        NavigationView {
            List{
                NavigationLink(destination: propertyDetailsView()) {
                    propertyRow()
                }
                NavigationLink(destination: propertyDetailsView()) {
                    propertyRow()
                }
                
            }.navigationBarTitle("Propriétés")
                .navigationBarItems( trailing:
                    Button("Add"){
                        self.isAddingProperty.toggle()
                        
                    }
                )
                .sheet(isPresented: $isAddingProperty) {
                        PropertyFormView()
                }
        }
    }
}


struct propertyRow: View {
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.red)
            }
            Spacer()
            VStack {
                Text("Prix : 200 000 €")
                Text("Surface : 100 ㎡")
            }
            Spacer()
        }
    }
}



//struct propertyDetails: View {
//
//    var body: some View {
//        Text("Details of property here")
//    }
//}


struct properties_Previews: PreviewProvider {
    static var previews: some View {
        propertyListView()
    }
}
