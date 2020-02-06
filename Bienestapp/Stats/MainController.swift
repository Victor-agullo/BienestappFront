//
//  MainController.swift
//  Bienestapp
//
//  Created by alumnos on 09/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
import AlamofireImage
import UserNotifications

// row guarda el índice de la app seleccionada
var row: Int?

// auth guarda la elección del usuario para las notificaciones
var auth: Bool?

class MainController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // representación del objeto vista en el que se hace la colección de apps
    @IBOutlet weak var AppCollection: UICollectionView!
    
    // al iniciarse la app se le pregunta al usuario por los permisos de notificaciones
    // y se realiza la obtención de toda la información necesaria.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // si el auth no tiene nada, se ejecuta esta función y si ya tiene valor, se salta
        if auth == nil {
            // salta un popup para aceptar o denegar las notificaciones
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) {
                (authorized, error) in
                
                // si el usuario autoriza las notificaciones, el bool de auth es true
                if authorized {
                    auth = true
                    
                // si el usuario no las autoriza, el bool es false
                } else {
                    auth = false
                }
            }
        }
        
        //declaraciones para que se sepa dónde mandar la información
        AppCollection.dataSource = self
        AppCollection.delegate = self
        
        // llamada a la clase serverRetriever que gestiona la información obtenida del servidor
        serverRetriever.init().infoGatherer(thisCollectionView: AppCollection, route: "times")
    }
    
    // método que marca el número de objetos que se van a mostrar
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    // método que rellena los objetos con la información
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // establecimiento de la celda donde se va a meter la información
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCells", for: indexPath) as! AppCells
        
        // transformación del string obtenido en una url para localizar la imagen
        let url = URL(string: imageURLArray[indexPath.row])
        
        // llenado de objetos do componentes de la celda
        cell.AppName.text = nameArray[indexPath.row]
        cell.AppTime.text = timeArray[indexPath.row]
        cell.AppIcon.af_setImage(withURL: url!)
        
        return cell
    }
    
    // método que responde a la selección de una app, llevando al usuario a un detalle de los tiempos de esta
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // variable que indica el índice de la app señalada
        row = indexPath.row
        
        // cambio de pantalla al detalle de los tiempos de la app seleccionada
        performSegue(withIdentifier: "Detailing", sender: Any?.self)
    }
}
