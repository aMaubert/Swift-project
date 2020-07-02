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
    @State private var formError: Bool = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(self.properties, id: \.self.id) { property in
                    NavigationLink(destination: propertyDetailsView(property: property)) {
                        propertyRow(property: property)
                    }
                }.onDelete{ indexSet in
                    indexSet.forEach { (index) in
                        let property = self.properties[index]
                        if let propertyId = property.id {
                            self.deletePropertyById(propertyId)
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.getAllProperties()
                    }
                }
                
            }
            .navigationBarTitle("Propriétés")
                .navigationBarItems( trailing:
                    Button("Add"){
                        self.isAddingProperty.toggle()
                    }
                )
                .sheet(isPresented: $isAddingProperty, onDismiss: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.getAllProperties()
                    }
                }) {
                    PropertyFormView(error: self.$formError)
            }.alert(isPresented: $formError) {
                Alert(title: Text("Echec de l'ajout de la propriété .")
                                .foregroundColor(.red)
                                .bold()
                )
            }
        }.onAppear {
            self.getAllProperties()
        }
    }
    
    
    public func deletePropertyById(_ propertyId: UInt64) {
        
        guard let bearerToken = StoreService.get(key: "TOKEN") else { return }
        
        //Get a session
        let session = URLSession.shared
        
        guard let url = URL(string: "\(PropertyService.baseUri())/\(propertyId)" ) else {
            return;
        }
        
        let request = PropertyService.makeUrlRequest( url:url, httpMethod: "DELETE", bearerToken: bearerToken)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            //Manage the result
            guard error == nil else { return }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    DispatchQueue.main.async {
                        Alert(title: Text("Echec de la suppression ."))
                    }
                }
            }
            
        }

        task.resume()
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
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                VStack(alignment: .leading) {
                    Text("Prix : \(self.property.price) €")
                    Text("Surface : \(self.property.surface) ㎡")
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text(self.property.address.city)
                    Text((String(self.property.address.postalCode)))
                }
                Spacer()
            }
        }
    }
}


struct properties_Previews: PreviewProvider {
    static var previews: some View {
        propertyListView()
    }
}
