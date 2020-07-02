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
        
        guard let bearerToken = StoreService.get(key: "TOKEN") else { return }
        
        //Get a session
        let session = URLSession.shared
        
        guard let url = URL(string: PropertyService.baseUri() ) else {
            return;
        }
        
        let request = PropertyService.makeUrlRequest(url:url, httpMethod: "GET", bearerToken: bearerToken)

        let task = session.dataTask(with: request) { (data, response, error) in

            //Manage the result
            guard error == nil else { return }
            guard let data = data else { return }

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


struct properties_Previews: PreviewProvider {
    static var previews: some View {
        propertyListView()
    }
}
