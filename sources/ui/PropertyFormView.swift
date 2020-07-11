//
//  PropertyFormView.swift
//  project
//
//  Created by allan on 29/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct PropertyFormView: View {
    
    @Binding var error: Bool
    
    @State private var price : Double = 0.0
    @State private var rooms : Int = 4
    @State private var surface : Double = 0.0
    @State private var transactionType : Property.TransactionType = .SALE
    
    @State private var propertyNumber : String = "11"
    @State private var streetName : String = "rue des marottes"
    @State private var postalCode : String = "78570"
    @State private var city : String = "Andrésy"
    @State private var country : String = "France"
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Propriété")) {
                    VStack {
                        Text("Prix : \(Formatter.formatDouble(self.price)) €")
                        Slider(value: $price, in: 0.0...5000000, step: 1000)
                    }
                    Picker("Transaction",
                    selection: $transactionType) {
                        ForEach(Property.TransactionType.allCases) { transaction in
                            Text( PropertyFormView.transactionFormat(transaction))
                        }
                      }
                                   
                    Stepper("Pièce(s) : \(self.rooms)", value: $rooms, in: 0...20, step: 1)
                    VStack {
                        Text("Surface : \(Formatter.formatDouble(self.surface)) ㎡")
                        Slider(value: $surface, in: 0.0...1000,step: 2)
                    }

                }
                Section(header: Text("Adresse")) {
                
                    TextField("Numéro de rue", text: $propertyNumber)
                    TextField("Voie", text: $streetName)
                    TextField("Code postal", text: $postalCode)
                        .keyboardType(.numberPad)
                    TextField("Ville", text: $city)
                    TextField("Pays", text: $country)
                    
                }
                Section(header: Text("Envoyer le formulaire")) {
                    HStack(alignment: .center){
                        Spacer()
                        Button("Ajouter") {
                            let address = Address(propertyNumber: self.propertyNumber, streetName: self.streetName, postalCode: Int(self.postalCode)!, city: self.city, country: self.country)
                            
                            let property = Property(id: nil, price: self.price, surface: self.surface, rooms: self.rooms, address: address, isAvailable: true, purchaser: nil, transactionType: self.transactionType)
                            self.postProperty(property: property)
                            self.presentation.wrappedValue.dismiss()
                            
                        }
                        Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        Button("Annuler") {
                            self.presentation.wrappedValue.dismiss()
                        }
                        Spacer()
                    }
                }
            }.navigationBarTitle("Ajout d'une propriété")
        }
    }
    
    func postProperty(property: Property) {
        guard let bearerToken = StoreService.get(key: "TOKEN") else {
            self.error = true
            return
        }
        
        //Get a session
        let session = URLSession.shared
        
        guard let url = URL(string: PropertyService.baseUri() ) else {
            self.error = true
            return
        }
        
        
        
        var request = PropertyService.makeUrlRequest(url:url, httpMethod: "POST", bearerToken: bearerToken)
        request.httpBody = PropertyService.encodeProperty(property: property)
        
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
    
    private static func transactionFormat(_ type: Property.TransactionType) -> String {
        if type == Property.TransactionType.SALE {
            return "Vente"
        }
        return "Location"
    }
   
}

struct PropertyFormView_Previews: PreviewProvider {
    @State static var formError: Bool = false
    static var previews: some View {
        PropertyFormView(error: $formError)
    }
}
