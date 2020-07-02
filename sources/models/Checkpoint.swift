//
//  Checkpoint.swift
//  project
//
//  Created by allan on 24/06/2020.
//  Copyright © 2020 allan. All rights reserved.
//

import MapKit

final class Checkpoint: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
      self.title = title
      self.coordinate = coordinate
    }
}
