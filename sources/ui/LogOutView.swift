//
//  LogOutView.swift
//  project
//
//  Created by allan on 18/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import SwiftUI

struct LogOutView: View {
    @Binding var logged: Bool
    @State var logoutError = false
    @State var logoutErrorMessage = ""
    
    var body: some View {
        Button(action: {
            self.signout()
        }) {
            Text("Déconnexion")
            Image(systemName: "square.and.arrow.up")
        }.alert(isPresented: $logoutError){
            Alert(title: Text(self.logoutErrorMessage)
                            .foregroundColor(.red)
                            .bold()
            )
        }.onDisappear{
            self.logoutErrorMessage = ""
        }
    }
    
    func signout(){
        guard let bearerToken = StoreService.get(key: "TOKEN") else {
            self.logoutError = true
            self.logoutErrorMessage = "don't have token ."
            return
        }
        print(bearerToken)
        
        let session = URLSession.shared
        
        
        guard let url = URL(string: "\(AuthentService.baseUri())/logout" ) else {
            self.logoutError = true
            self.logoutErrorMessage = "URL ERROR ."
            return
        }
        
        let request = AuthentService.makeUrlRequest( url:url, httpMethod: "POST", bearerToken: bearerToken)
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            //Manage the result
            guard error == nil else {
                self.logoutError = true
                self.logoutErrorMessage = "error \(String(describing: error))."
                return
            }
            guard let dataUnwrapped = data else {
                self.logoutErrorMessage = "No data ."
                self.logoutError = true
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 403 {
                    self.logoutErrorMessage = String(data: dataUnwrapped, encoding: .utf8)!
                    self.logoutError = true
                    return
                } else if response.statusCode != 204 {
                    self.logoutErrorMessage = String(data: dataUnwrapped, encoding: .utf8)!
                    self.logoutError = true
                    return
                }
            }
            
            StoreService.set(key: "TOKEN", value: nil)
            self.logged = false
        }

        task.resume()
    }
}

struct LogOutView_Previews: PreviewProvider {
    @State static var logged = true
    
    static var previews: some View {
        LogOutView(logged: $logged)
    }
}
