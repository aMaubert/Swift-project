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
    @State var authentError = false
    @State var authentErrorMessage = ""
    
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
                SecureField("Mot de passe", text: $password)
                  .padding(.leading)
                  .padding(.trailing)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
                  
              }.frame(width: 300, height: 300)
              .background(Color(.gray))
                      
            }.cornerRadius(27)
            Spacer()
            
            Button(action: {
                self.authenticate()
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
        }.alert(isPresented: $authentError){
            Alert(title: Text(self.authentErrorMessage)
                            .foregroundColor(.red)
                            .bold()
            )
            
        }.onDisappear{
            self.authentErrorMessage = ""
        }
    }
    
    func authenticate() {
        
        let session = URLSession.shared
        
        
        guard let url = URL(string: "\(AuthentService.baseUri())/login" ) else {
            return
        }
        
        var request = AuthentService.makeUrlRequest( url:url, httpMethod: "POST", bearerToken: nil)
        
        let accountLogin = AccountLogin(login: self.login, password: self.password)
        request.httpBody = AuthentService.encodeAccountLogin(accountLogin)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            //Manage the result
            guard error == nil else {
                return
            }
             guard let data = data else {
                print("Error, pas de data")
                self.authentError = true
                return
            }
            if let response = response as? HTTPURLResponse {
                
                
                if response.statusCode == 403 {
                    self.authentError = true
                    self.authentErrorMessage = "Mauvais Login ou mot de passe ."
                } else if response.statusCode != 200 {
                    self.authentError = true
                    self.authentErrorMessage = "Une erreur est survenue . (code : \(response.statusCode))"
                }
            }
            
            guard let token = AuthentService.decodeToken(data) else {
                self.authentError = true
                return
            }
            
            StoreService.set(key: "TOKEN", value: "Bearer \(token.token)")
            self.logged = true
            
        }

        task.resume()
        
        
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
            Text("Connnexion")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(secondaryColor)
            Spacer()
        }
    }
}

struct login_Previews: PreviewProvider {
    @State static var secondaryColor = Color.white
    @State static var logged = false
    
    static var previews: some View {
        LoginView(secondaryColor: $secondaryColor ,
            logged: $logged)
    }
}
