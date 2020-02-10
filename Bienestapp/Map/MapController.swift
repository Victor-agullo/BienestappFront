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
    
    // referencia a la clase que maneja las peticiones
    var HttpMessenger = HTTPMessenger()
    
    // objeto de vista del mapa donde se muestra éste
    @IBOutlet weak var map: MKMapView!
    
    // variables que apoyan en la localización del usuario
    // y las coordenadas de objetos
    let manager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    // Arrays que llevan las localizaciones
    var locationArray: NSArray?
    var latitudeArray: Array<String> = []
    var longitudeArray: Array<String> = []
    
    // cuando se carga la pantalla se realiza la petición
    // al servidor y se cargan todos los puntos en el mapa
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlaces()
        
        // Comprueba si los servicios de localización
        // están permitidos, de no estarlo no aparecerían
        // los puntos en el mapa
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.requestWhenInUseAuthorization()
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.distanceFilter = kCLDistanceFilterNone
            manager.startUpdatingLocation()
        }
        
        // cargan la posición del dispositivo, de una brújula
        // y de la escala del mapa
        map.showsUserLocation = true
        map.showsCompass = true
        map.showsScale = true
    }
    
    // con los datos de latitud y longitud del teléfono, posiciona al usuario en el mapa
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //recoge la localización del tlf
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        // establece la localización
        let currentLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        
        // el perímetro en el que se encuentra la localización desde el centro de la pantalla a los
        // bordes a escala
        let regionRadius: CLLocationDistance = 4000.0
        
        // con todos los datos establece la región
        let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        // y la región la ubica en el mapa
        map.setRegion(region, animated: true)
    }
    
    // método para sacar la ubicación de las apps del servidor
    func getPlaces() {
        
        // petición de información simple
        let locations = HttpMessenger.get(endpoint: "trace")
        
        // tratado de la respuesta
        locations.responseJSON { response in
            
            // recoge el json de la respuesta
            if let JSON = response.result.value {
                
                // lo transforma en un array
                self.locationArray = JSON as? NSArray
                
                // y lo abre en un bucle, pasándolo a diccionario
                for item in self.locationArray! as! [NSDictionary] {
                    
                    // los valores de latitud y longitud se almacenan en variables
                    let latitude = item["latitude"] as! String
                    let longitude = item["longitude"] as! String
                    
                    // y luego se pasan a los arrays para manejarlas
                    self.latitudeArray.append(latitude)
                    self.longitudeArray.append(longitude)
                }
                self.createAnnotations()
            }
        }
    }
    
    // tras la obtención de ubicaciones se crean los iconos
    // para señalar dichos lugares
    func createAnnotations() {
        
        // creación de variables para el uso de la información
        var locations = 0
        let latitudes = latitudeArray.count
        let longitudes = longitudeArray.count
        
        // si el número de ambas es el mismo, se resta 1 a la cuenta
        if latitudes == longitudes {
            locations = latitudes - 1
        }
        
        // así no se pasa del índice
        for locations in 0...locations {
            let annotation = MKPointAnnotation()
            
            // edición de datos de la marca de mapa
            annotation.title = serverRetriever.nameArray[locations]
            annotation.subtitle = serverRetriever.timeArray[locations]
            
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
