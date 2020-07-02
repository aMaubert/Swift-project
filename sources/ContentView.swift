//
//  ContentView.swift
//  project
//
//  Created by allan on 17/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        HomeView()
            .onAppear {
                StoreService.set(key: "API_BASE_URL", value: "http://localhost:8080")
                StoreService.set(key: "TOKEN", value: "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJST0xFX0FkbWluLFJPTEVfVXNlciIsImV4cCI6MTU5MzcyOTUyMH0.1WvmjFoUx6vP3t6VklILHxa7azYb6VLvUCHNEcPv5Qs")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AppBarView: View {
    
    @Binding var secondaryColor: Color
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Where IS My Home")
                    .font(Font.title)
                    .fontWeight(.bold)
                    .foregroundColor(secondaryColor)
                Text("Search your Home")
                    .fontWeight(.medium)
                    .foregroundColor(secondaryColor)
            }
            Spacer()
            Image(systemName: "house.fill")
                .font(.system(size: 72))
                .foregroundColor(secondaryColor)
            
        }
    }
}

