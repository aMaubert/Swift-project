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
    
    var body: some View {
        Button(action: {
            self.logged = false
        }) {
            Text("Log Out")
            Image(systemName: "square.and.arrow.up")
        }
    }
}

struct LogOutView_Previews: PreviewProvider {
    @State static var logged = true
    
    static var previews: some View {
        LogOutView(logged: $logged)
    }
}
