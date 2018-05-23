//
//  MapAnnotationView.swift
//  AppleMapsDemo
//
//  Created by Sayalee on 5/23/18.
//  Copyright © 2018 Assignment. All rights reserved.
//

import Foundation
import MapKit

class MapAnnotionView: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
}
