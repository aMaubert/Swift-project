//
//  propertyDetailsView.swift
//  project
//
//  Created by allan on 18/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct propertyDetailsView: View {
    
    @State var property : Property
    @State var checkpoints = Array<Checkpoint>()
    @State private var isBuying = false
    private let distance : UInt = 20
    @State private var propertyId: UInt64 = 8
    
    var body: some View {
            VStack {
                VStack {
                    Text("Property")
                    .frame(width: 400, height: 30)
                    .background(Color(.gray))
                    .foregroundColor(.white)
                    HStack {
                        Spacer()
                        Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 64, height: 64)
                        Spacer()
                        VStack(alignment: .leading) {

                            Text("Price : \( self.property.price ) euros")
                                .bold()
                            Text("Transaction : \( self.property.transactionType.rawValue )")
                                .bold()
                            Text("La surface  : \( self.property.surface ) m2")
                                .bold()
                            Text("Nombres de chambres  : \( self.property.rooms )")
                                .bold()
                            Text("Disponbile  : \( self.property.isAvailable ? "oui" : "non" )")
                                .bold()
                                .foregroundColor(.green)
                            Text("Acheteur  : \( self.getUserName(property: self.property) )")
                                .bold()
                        }
                        Spacer()
                    }
                }.frame(height: 100, alignment: .topLeading)
                Spacer()
                Spacer()
                Spacer()

                VStack(alignment: .trailing) {
                    Text("Address")
                        .frame(width: 400, height: 30)
                        .background(Color(.gray))
                        .foregroundColor(.white)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("\(self.property.address.propertyNumber) \(self.property.address.streetName)")
                           .bold()
                        Text("Ville : \(self.property.address.city)")
                           .bold()
                       Text("Pays  : \(self.property.address.country)")
                           .bold()
                        Text("Code postal : \(self.property.address.postalCode)")
                           .bold()
                    }.frame(width: 400)
                    Spacer()
                }.frame(width: 400, height: 200)
                Spacer()
                NavigationLink(destination: MapView(propertyId: $propertyId)
                    .edgesIgnoringSafeArea(.all)
                ) {
                    Text("Map View")
                }
                Spacer()
            }.onAppear{
                if let propertyId = self.property.id {
                    self.propertyId = propertyId
                }
            }.navigationBarTitle("Property details")
            .navigationBarItems(trailing: Button("Acheter") {
                self.isBuying = true
            })
            .actionSheet(isPresented: $isBuying) {
                ActionSheet(title: Text("Acheter la propriété"),
                            message: Text("Achat au prix de \(self.property.price) euros"),
                            buttons: [
                                .default(Text("Acheter"), action: {
                                 
                                }),
                                .cancel()
                            ]
                )
        }
    }
    
    func getUserName(property: Property) -> String {
        if let user = property.purchaser {
            return "\(user.firstName) \(user.lastName)"
        }
        return "Pas d'Acheteur"
    }
    
}

struct propertyDetailsView_Previews: PreviewProvider {
    
//    @State static var address = Address(id: 1, propertyNumber: "11A", streetName: "rue des entrechats", postalCode: 75002, city: "Paris", country: "France")
    @State static var property = Property(id: 1, price: 200000, surface: 1234, rooms: 4, address: Address(id: 1, propertyNumber: "11A", streetName: "rue des entrechats", postalCode: 75002, city: "Paris", country: "France"), isAvailable: true, purchaser: nil, transactionType: Property.TransactionType.SALE)
    
    static var previews: some View {
        propertyDetailsView(property: property)
    }
}
