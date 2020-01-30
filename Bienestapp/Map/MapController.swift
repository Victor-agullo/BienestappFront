//
//  MapController.swift
//  Bienestapp
//
//  Created by alumnos on 27/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController, CLLocationManagerDelegate {
    
    var HttpMessenger = HTTPMessenger()
    @IBOutlet weak var map: MKMapView!
    let manager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    var locationArray: NSArray?
    var latitudeArray: Array<String> = []
    var longitudeArray: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlaces()
        
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.requestWhenInUseAuthorization()
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.distanceFilter = kCLDistanceFilterNone
            manager.startUpdatingLocation()
        }
        
        map.showsUserLocation = true
        map.showsCompass = true
        map.showsScale = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        let currentLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        
        let regionRadius: CLLocationDistance = 4000.0
        
        let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        map.setRegion(region, animated: true)
    }
    
    func getPlaces() {
        let locations = HttpMessenger.get(endpoint: "trace")
        
        locations.responseJSON { response in
            
            if let JSON = response.result.value {
                self.locationArray = JSON as? NSArray
                
                for item in self.locationArray! as! [NSDictionary] {
                    
                    let latitude = item["latitude"] as! String
                    
                    let longitude = item["longitude"] as! String
                    
                    self.latitudeArray.append(latitude)
                    self.longitudeArray.append(longitude)
                }
                self.createAnnotations()
            }
        }
    }
    
    func createAnnotations() {
        var locations = 0
        let latitudes = latitudeArray.count
        let longitudes = longitudeArray.count
        
        if latitudes == longitudes {
            locations = latitudes - 1
        }
        
        for locations in 0...locations {
            let annotation = MKPointAnnotation()
            
            annotation.title = nameArray[locations]
            annotation.subtitle = timeArray[locations]
            
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: CLLocationDegrees(latitudeArray[locations])!,
                longitude: CLLocationDegrees(longitudeArray[locations])!)
            
            self.map.addAnnotation(annotation)
        }
    }
    
    // Implementar función de selección del protocolo
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title! as Any)
    }
}
