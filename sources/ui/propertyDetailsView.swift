//
//  propertyDetailsView.swift
//  project
//
//  Created by allan on 18/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct propertyDetailsView: View {
    @State var checkpoints = [
          Checkpoint(title: "Gare de Nations", coordinate: .init(latitude: 48.862725, longitude: 2.287592))
        ]
    @State private var isBuying = false
    
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

                            Text("Price : Here the price")
                                .bold()
                            Text("Transaction : En vente")
                                .bold()
                            Text("La surface  : 4000 m2")
                                .bold()
                            Text("Nombres de chambres  : 5")
                                .bold()

                            Text("Disponbile  : Oui")
                                .bold()
                                .foregroundColor(.green)

                            Text("Acheteur  : Jean Dupond")
                                .bold()
                        }
                        Spacer()
                    }
                }.frame(height: 100, alignment: .topLeading)
                Spacer()

                VStack(alignment: .trailing) {
                    Text("Address")
                        .frame(width: 400, height: 30)
                        .background(Color(.gray))
                        .foregroundColor(.white)
                    Spacer()
                    VStack(alignment: .leading) {

                       Text("Price : Here the price")
                           .bold()
                       Text("Transaction : En vente")
                           .bold()
                       Text("La surface  : 4000 m2")
                           .bold()
                       Text("Nombres de chambres  : 5")
                           .bold()

                       Text("Disponbile  : Oui")
                           .bold()
                           .foregroundColor(.green)

                       Text("Acheteur  : Jean Dupond")
                           .bold()
                    }.frame(width: 400)
                    Spacer()
                }.frame(width: 400, height: 200)
                Spacer()
                NavigationLink(destination: MapView(checkpoints: $checkpoints)
                    .edgesIgnoringSafeArea(.all)
                ) {
                    Text("Map View")
                }
                Spacer()
        }.navigationBarTitle("Property details")
            .navigationBarItems(trailing: Button("Acheter") {
                self.isBuying = true
            })
        
    }
}

struct propertyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        propertyDetailsView()
    }
}
