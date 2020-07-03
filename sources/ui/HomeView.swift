//
//  HomeView.swift
//  project
//
//  Created by allan on 18/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State var primaryColor: Color = .orange
    @State var secondaryColor: Color = .white
    @State var logged = false
    
    
    var body: some View {
        ZStack{
            if logged == true {
                TabView {
                    propertyListView()
                        .tabItem {
                            Text("Propriétés")
                            Image(systemName: "list.bullet")
                        }
                    AmenityListView()
                        .tabItem {
                           Text("Services")
                            Image(systemName: "list.bullet")
                        }
                
                    
                    LogOutView(logged: $logged)
                        .tabItem {
                            Text("Déconnexion")
                            Image(systemName: "square.and.arrow.up")
                        }
                }
            } else {
                    LoginView(secondaryColor: $secondaryColor,
                    logged: $logged)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
