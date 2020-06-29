//
//  MapView.swift
//  project
//
//  Created by allan on 24/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import MapKit
import SwiftUI



struct MapView: UIViewRepresentable {
    
    @Binding var checkpoints: [Checkpoint]
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    func updateUIView(_ uiView: MKMapView,
                      context: Context) {
        uiView.addAnnotations(checkpoints)
    }
}

struct MapView_Previews: PreviewProvider {
    @State static var checkpoints  = [
      Checkpoint(title: "Da Nang", coordinate: .init(latitude: 16.047079, longitude: 108.206230)),
      Checkpoint(title: "Ha Noi", coordinate: .init(latitude: 21.027763, longitude: 105.834160))
    ]

    static var previews: some View {
        MapView(checkpoints: $checkpoints)
    }
}
