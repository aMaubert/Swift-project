//
//  AmenityListView.swift
//  project
//
//  Created by allan on 18/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct AmenityListView: View {
        
    @State private var amenities = [Amenity]()
    @State private var displayForm: Bool = false
    @State private var formError: Bool = false
    @State private var deleteError: Bool = false
    @State private var fetchError: Bool = false
    
    var body: some View {
        NavigationView {
            List(self.amenities){ amenity in
                NavigationLink(destination: AmenityDetailsView(amenity: amenity)) {
                    AmenityRow(amenity: amenity)
                }
            }.navigationBarTitle("Services")
                .navigationBarItems( trailing:
                    HStack{
                        AmenityAddButton(displayForm: $displayForm)
                    }
                )
        }.onAppear {
            self.getAllAmenities()
        }
        .sheet(isPresented: $displayForm){
            AmenityFormView()
        }.alert(isPresented: $formError) {
            Alert(title: Text("Echec de l'ajout du service .")
                            .foregroundColor(.red)
                            .bold()
            )
        }.alert(isPresented: $deleteError) {
            Alert(title: Text("Echec de la suppression du service .")
                            .foregroundColor(.red)
                            .bold()
            )
        }.alert(isPresented: $fetchError) {
            Alert(title: Text("Echec de la récupération des services .")
                            .foregroundColor(.red)
                            .bold()
            )
        }
            
        
    }
    
    func getAllAmenities() {
        guard let bearerToken = StoreService.get(key: "TOKEN") else {
            self.fetchError = true
            return
        }
        
        //Get a session
        let session = URLSession.shared
        
        guard let url = URL(string: AmenityService.baseUri() ) else {
            self.fetchError = true
            return
        }
        
        let request = AmenityService.makeUrlRequest(url:url, httpMethod: "GET", bearerToken: bearerToken)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                self.fetchError = true
                return
            }
            guard let data = data else {
                self.fetchError = true
                return
            }
                    
            if let amenities = AmenityService.decodeAmenities(from: data) {
               DispatchQueue.main.async {
                   self.amenities = amenities
               }
           }
        }
        task.resume()
    }
}


struct AmenityAddButton: View {
    
    @Binding var displayForm : Bool
    
    var body: some View {
        Button(action: {
            self.displayForm.toggle()
        }){
            Image(systemName: "plus.circle.fill")
            .resizable()
            .frame(width: 30, height: 30)
        }
    }
}

struct AmenityRow: View {
    var amenity: Amenity
    var body: some View {
        VStack(alignment: .leading) {
            Text("nom : \(self.amenity.name)")
            Text("type : \(self.amenity.type)")
        }
    }
}

struct AmenityListView_Previews: PreviewProvider {
    static var previews: some View {
        AmenityListView()
    }
}
