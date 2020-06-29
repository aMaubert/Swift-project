//
//  login.swift
//  project
//
//  Created by allan on 17/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI




struct LoginView: View {
    
    @Binding var secondaryColor: Color
    @Binding var logged: Bool
    
    var body: some View {
        
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.orange, self.secondaryColor]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                VStack{
                  AppBarView(secondaryColor: $secondaryColor)
                  Spacer()
                  
                  LoginCardView(secondaryColor: $secondaryColor,
                                logged: $logged)
                  Spacer()
                  
              }.padding(.all )
            }
        }
        
        
    }
}



struct LoginCardView: View {
    
    @Binding var secondaryColor: Color
    @Binding var logged: Bool
    @State var login: String = ""
    @State var password = ""
    
    var body: some View {
        VStack{
            Spacer()
            HStack(alignment: .center){
              VStack(alignment: .center){
                  
                Spacer()
                LoginCardHeader(secondaryColor: $secondaryColor)
                Spacer()
                TextField("Login ", text: $login)
                  .padding(.leading)
                  .padding(.trailing)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                  .padding(.leading)
                  .padding(.trailing)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
                  
              }.frame(width: 300, height: 300)
              .background(Color(.gray))
                      
            }.cornerRadius(27)
            Spacer()
            
            Button(action: {
                self.logged = true
                               
           }){
               Text("Connexion")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(secondaryColor)
                .frame(minWidth: 0, maxWidth: .infinity)
            
            }.background(Color(.gray))
             .cornerRadius(45)
                .padding([.leading, .trailing], 80)
        Spacer()
        }
    }
}

struct LoginCardHeader: View {
    
    @Binding var secondaryColor: Color
    
    var body: some View {
        HStack{
            Spacer()
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .scaledToFit()
                .foregroundColor(secondaryColor)
            Spacer()
            Text("Login")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(secondaryColor)
            Spacer()
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//
//    @State static var color = Color.white
//    static var previews: some View {
//        LoginView(secondaryColor: $color)
//    }
//}

struct login_Previews: PreviewProvider {
    @State static var secondaryColor = Color.white
    @State static var logged = false
    
    static var previews: some View {
        LoginView(secondaryColor: $secondaryColor ,
            logged: $logged)
    }
}
