//
//  AmenityFormView.swift
//  project
//
//  Created by allan on 03/07/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct AmenityFormView: View {
    
    @State private var name : String = ""
    @State private var type : String = ""
    
    @State private var propertyNumber : String = "11"
    @State private var streetName : String = "rue des marottes"
    @State private var postalCode : String = "78570"
    @State private var city : String = "Andrésy"
    @State private var country : String = "France"
    
    @Binding public var error: Bool
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        NavigationView{
            
            Form {
                Section {
                    TextField("Name : ", text: $name)
                    TextField("Type : ", text: $type)
                }
                Section(header: Text("Address")) {
                    TextField("Numero de rue", text: $propertyNumber)
                    TextField("la Voie", text: $streetName)
                    TextField("Code postal", text: $postalCode)
                        .keyboardType(.numberPad)
                    TextField("Ville", text: $city)
                    TextField("pays", text: $country)
                }
                Section {
                    HStack{
                        Spacer()
                        Button("Ajouter"){
                            let address = Address(propertyNumber: self.propertyNumber, streetName: self.streetName, postalCode: Int(self.postalCode)!, city: self.city, country: self.country)
                            
                            let amenity = Amenity(id: nil, type: self.type, name: self.name, address: address)
                            self.createAmenity(amenity: amenity)
                            self.presentation.wrappedValue.dismiss()
                        }
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Button("Annuler"){
                            self.presentation.wrappedValue.dismiss()
                        }
                        Spacer()
                    }
                    
                }
            }.navigationBarTitle("Ajout d'un Service")
        }
    }
    
    func createAmenity(amenity: Amenity) {
        guard let bearerToken = StoreService.get(key: "TOKEN") else {
            self.error = true
            return
            
        }
        
        //Get a session
        let session = URLSession.shared
        
        guard let url = URL(string: AmenityService.baseUri() ) else {
            self.error = true
            return
        }
        
        var request = AmenityService.makeUrlRequest(url:url, httpMethod: "POST", bearerToken: bearerToken)
        request.httpBody = AmenityService.encodeAmenity(amenity: amenity)
        
        let task = session.dataTask(with: request) { (data, response, error) in

            //Manage the result
            guard error == nil else {
                self.error = true
                return
            }
            guard data != nil else {
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 201 {
                    DispatchQueue.main.async {
                        self.error = true
                    }
                }
            }
            
        }
        task.resume()
    }
}

struct AmenityFormView_Previews: PreviewProvider {
    @State public static var error: Bool = false
    
    static var previews: some View {
        AmenityFormView(error: $error)
    }
}
