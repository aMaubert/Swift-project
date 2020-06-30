//
//  PropertyFormView.swift
//  project
//
//  Created by allan on 29/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct PropertyFormView: View {
    
    @State private var price : Double = 0.0
    @State private var rooms : Int8 = 4
    @State private var surface : Double = 0.0
    @State private var transactionType : Property.TransactionType = .SALE
    
    @State private var propertyNumber : String = ""
    @State private var streetName : String = ""
    @State private var postalCode : String = ""
    @State private var city : String = ""
    @State private var country : String = ""
    
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Property members")) {
                    HStack {
                      Text("Prix : \(self.price)")
                      Slider(value: $price)
                    }
                    Picker("Transaction type",
                    selection: $transactionType) {
                        ForEach(Property.TransactionType.allCases) { transaction in
                            Text(transaction.rawValue)
                        }
                      }
                                   
                    Stepper("rooms : \(self.rooms)", value: $rooms, in: 0...20, step: 1)
                    HStack {
                        Text("surface : \(self.surface)")
                        Slider(value: $surface, in: 0...1000000,step: 10)
                    }
                    
                }
                Section(header: Text("Address members")) {
                
                    TextField("Numero de rue", text: $propertyNumber)
                    TextField("la Voie", text: $streetName)
                    TextField("Code postal", text: $postalCode)
                        .keyboardType(.numberPad)
                    TextField("Ville", text: $city)
                    TextField("pays", text: $country)
                    
                    
                }
                Section(header: Text("Envoyer le formulaire")) {
                    HStack {
                        Spacer()
                        Button("Save") {
                            print("Test")
                            self.presentation.wrappedValue.dismiss()
                        }
                        Spacer()
                        Button("Cancel") {
                            self.presentation.wrappedValue.dismiss()
                        }
                        Spacer()
                    }
                    
                }
            }.navigationBarTitle("Property  Form")
        }
        
    }
}

struct PropertyFormView_Previews: PreviewProvider {
    
    static var previews: some View {
        PropertyFormView()
    }
}
