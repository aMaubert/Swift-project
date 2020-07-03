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
}

struct AmenityFormView_Previews: PreviewProvider {
    static var previews: some View {
        AmenityFormView()
    }
}
