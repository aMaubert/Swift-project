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
    
    @State public var error: Bool = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(self.amenities, id: \.self.id){ amenity in
                    NavigationLink(destination: AmenityDetailsView(amenity: amenity)) {
                        AmenityRow(amenity: amenity)
                    }
                }.onDelete{ indexSet in
                    indexSet.forEach { (index) in
                       let amenity = self.amenities[index]
                       if let amenityId = amenity.id {
                           self.deleteAmenityById(amenityId)
                       }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.getAllAmenities()
                    }
                    
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
        .sheet(isPresented: $displayForm, onDismiss: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
               if self.error == true {
                   print("error")
                   return
               } else {
                   self.getAllAmenities()
               }
             }
        }){
            AmenityFormView(error: self.$error)
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
    
    public func deleteAmenityById(_ amenityId: UInt64) {
           
           guard let bearerToken = StoreService.get(key: "TOKEN") else {
               self.error = true
               return
               
           }
           
           //Get a session
           let session = URLSession.shared
           
           guard let url = URL(string: "\(AmenityService.baseUri())/\(amenityId)" ) else {
               self.error = true
               return
           }
           
           let request = AmenityService.makeUrlRequest( url:url, httpMethod: "DELETE", bearerToken: bearerToken)
           
           let task = session.dataTask(with: request) { (data, response, error) in
               
               //Manage the result
               guard error == nil else {
                   self.error = true
                   return
               }
               
               if let response = response as? HTTPURLResponse {
                   if response.statusCode != 200 {
                       self.error = true
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
            Text("Nom : \(self.amenity.name)")
            Text("Type : \(self.amenity.type)")
        }
    }
}

struct AmenityListView_Previews: PreviewProvider {
    static var previews: some View {
        AmenityListView()
    }
}
