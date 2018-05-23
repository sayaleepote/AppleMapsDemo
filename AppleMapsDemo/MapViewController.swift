//
//  MapViewController.swift
//  AppleMapsDemo
//
//  Created by Sayalee on 5/22/18.
//  Copyright © 2018 Assignment. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var location: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initialiseMap() {
        if let lat = location?.lat, let long = location?.long, let title = location?.title {
            let location = CLLocation(latitude: Double(lat)!, longitude: Double(long)!)
            let regionRadius: CLLocationDistance = 1000
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
             mapView.setRegion(coordinateRegion, animated: true)
            let annotation = MapAnnotionView(title: title, locationName: "", coordinate: CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!))
            mapView.addAnnotation(annotation)
        }
    }
}
