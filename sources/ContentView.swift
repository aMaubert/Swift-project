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

