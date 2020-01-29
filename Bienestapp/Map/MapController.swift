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

class MapController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var HttpMessenger = HTTPMessenger()
    @IBOutlet weak var map: MKMapView!
    let manager = CLLocationManager()
    
    var locationArray: NSArray?
    var latitudeArray: Array<String> = []
    var longitudeArray: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlaces()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        map.delegate = self
    }
    
    func getPlaces() {
        let locations = HttpMessenger.get(endpoint: "trace")
        
        locations.responseJSON { response in
            
            if let JSON = response.result.value {
                
                self.locationArray = JSON as? NSArray
                print(self.locationArray!)
                for item in self.locationArray! as! [NSDictionary] {
                    
                    let latitude = item["latitude"] as! String
                    print(latitude)
                    let longitude = item["longitude"] as! String
                    print(longitude)
                    self.latitudeArray.append(latitude)
                    self.longitudeArray.append(longitude)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        pin(localizacion: locations.first!)
    }
    
    func pin(localizacion: CLLocation) {
        for i in 1..<longitudeArray.count {
            
            let span = MKCoordinateSpan(latitudeDelta:Double(latitudeArray[i])!, longitudeDelta: Double(longitudeArray[i])!)
            
            let region = MKCoordinateRegion(center: localizacion.coordinate, span: span)
            
            map.setRegion(region, animated: true)
            
            let anotacion = MKPointAnnotation()
            anotacion.coordinate = localizacion.coordinate
            anotacion.title = nameArray[i]
            
            anotacion.subtitle = timeArray[i]
            
            map.addAnnotation(anotacion)
        }
    }
    
    // Implementar función de selección del protocolo
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title! as Any)
    }
}
