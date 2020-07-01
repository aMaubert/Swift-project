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
    @State private var properties = [Property]()

    var body: some View {
        
        NavigationView {
            List(self.properties ){ property in
                NavigationLink(destination: propertyDetailsView(property: property)) {
                         propertyRow(property: property)
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
        }.onAppear {
            self.getAllProperties()
        }
    }
    
    
    public func getAllProperties(){
        
        let bearerToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJST0xFX0FkbWluLFJPTEVfVXNlciIsImV4cCI6MTU5MzY0NzY3OH0.V4llhsyLs_uTduMMHBos8GeFAlf3uZ3_WLo9yt8YUxA"
        
        //Get a session
        let session = URLSession.shared
        
        guard let url = URL(string: PropertyService.baseUri ) else {
            return;
        }
        
        let request = PropertyService.makeUrlRequest(url:url, httpMethod: "GET", bearerToken: bearerToken)

        let task = session.dataTask(with: request) { (data, response, error) in

            //Manage the result
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }

            if let properties = PropertyService.decodeProperties(from: data) {
                DispatchQueue.main.async {
                    self.properties = properties
                }
                
               
            }

        }
        
        task.resume()
    }
}


struct propertyRow: View {
    
    var property: Property
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.red)
            }
            Spacer()
            VStack {
                Text("Prix : \(self.property.price) €")
                Text("Surface : \(self.property.surface) ㎡")
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
