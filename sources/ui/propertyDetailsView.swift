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
                propertySectionView(property: self.property)
                Spacer()
                Spacer()
                addressSectionView(property: self.property)
                Spacer()
                NavigationLink(destination: MapView(propertyId: $propertyId)
                    .edgesIgnoringSafeArea(.all)
                ) {
                    HStack {
                        Spacer()
                        Image(systemName: "map.fill")
                            .foregroundColor(.white)
                            .frame(width: 80, height: 80)
                        Spacer()
                        Text("Regarder sur la carte")
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "arrowtriangle.right.fill")
                            .foregroundColor(.white)
                            .frame(width: 80, height: 80)
                        Spacer()
                    }.background(Color(.lightGray))
                }
                Spacer()
            }.onAppear{
                if let propertyId = self.property.id {
                    self.propertyId = propertyId
                }
             }
             .navigationBarTitle("Property details")
             .navigationBarItems(trailing: Button("Acheter") {
                self.isBuying = true
             })
             .actionSheet(isPresented: $isBuying) {
                ActionSheet(title: Text("Acheter la propriété"),
                            message: Text("Achat au prix de \(self.property.price.rounded(.toNearestOrAwayFromZero)) euros"),
                            buttons: [
                                .default(Text("Acheter"), action: {
                                }),
                                .cancel()
                            ]
                )
        }
    }
    
}


struct addressSectionView: View {
    
    var property: Property
    
    var body: some View {
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
                Text("Code postal : \(String(self.property.address.postalCode))")
                   .bold()
            }.frame(width: 400)
            Spacer()
        }.frame(width: 400, height: 200)
    }
}

struct propertySectionView : View {
    
    var property: Property
    
    var body: some View {
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

                    Text("Price : \( self.doubleToFormatedString(self.property.price)) euros")
                        .bold()
                    Text("Transaction : \( propertySectionView.transactionFormat(self.property.transactionType) )")
                        .bold()
                    Text("La surface  : \( self.doubleToFormatedString(self.property.surface)) m2")
                        .bold()
                    Text("Pieces  : \( self.property.rooms )")
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
    }
    
    func getUserName(property: Property) -> String {
       if let user = property.purchaser {
           return "\(user.firstName) \(user.lastName)"
       }
       return "Pas d'Acheteur"
    }
    
    private static func transactionFormat(_ type: Property.TransactionType) -> String {
        if type == Property.TransactionType.SALE {
            return "Vente"
        }
        return "Location"
    }
        
    private func doubleToFormatedString(_ number: Double) -> String {
        return String(format: "%.2f", number)
    }
}

struct propertyDetailsView_Previews: PreviewProvider {
    
//    @State static var address = Address(id: 1, propertyNumber: "11A", streetName: "rue des entrechats", postalCode: 75002, city: "Paris", country: "France")
    @State static var property = Property(id: 1, price: 200000, surface: 1234, rooms: 4, address: Address(id: 1, propertyNumber: "11A", streetName: "rue des entrechats", postalCode: 75002, city: "Paris", country: "France"), isAvailable: true, purchaser: nil, transactionType: Property.TransactionType.SALE)
    
    static var previews: some View {
        propertyDetailsView(property: property)
    }
}
