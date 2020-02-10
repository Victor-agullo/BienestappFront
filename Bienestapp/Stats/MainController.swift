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

class MainController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // referencias a los controladores necesarios en esta pantalla
    private var httpMessenger = HTTPMessenger.init()
    
    // row guarda el índice de la app seleccionada
    static var row: Int?
    
    // auth guarda la elección del usuario para las notificaciones
    static var auth: Bool?
    
    // representación del objeto vista en el que se hace la colección de apps
    @IBOutlet weak var AppCollection: UICollectionView!
    
    // al iniciarse la app se le pregunta al usuario por los permisos de notificaciones
    // y se realiza la obtención de toda la información necesaria.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // si hay una variable de auth guardada, la establece
        if (UserDefaults.standard.value(forKey: "auth") != nil) {
            MainController.auth = (UserDefaults.standard.value(forKey: "auth") as! Bool)
        }
        
        // si el auth no tiene nada, se ejecuta esta función y si ya tiene valor, se salta
        if MainController.auth == nil {
            
            // salta un popup para aceptar o denegar las notificaciones
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) {
                (authorized, error) in
                
                // si el usuario autoriza las notificaciones, el bool de auth es true
                if authorized {
                    MainController.auth! = true
                    
                    // si el usuario no las autoriza, el bool es false
                } else {
                    MainController.auth! = false
                }
            }
        }

        // si la app está autorizada, comparará el tiempo usado de las apps
        // y si se ha excedido, mandará un mensaje
        if MainController.auth! == true {
            notification()
        }
        
        //declaraciones para que se sepa dónde mandar la información
        AppCollection.dataSource = self
        AppCollection.delegate = self
        
        // llamada a la clase serverRetriever que gestiona la información obtenida del servidor
        serverRetriever.infoGatherer(thisCollectionView: AppCollection, route: "times")
    }
    
    // método por el que se comunica con el server para notificar un exceso
    private func notification() {
        let apps = httpMessenger.get(endpoint: "checkRestrictions")
        
        apps.responseJSON { response in
            // guardado de la respuesta, de haberla, en una variable
            if let JSON = response.result.value {
                
                // conversión de la respuesta en un array y guardado de este
                let jsonArray = JSON as? NSArray
                
                //se crea una variable donde estarán los nombres de las apps
                var appRestricted: Array<String> = []
                
                // se realiza un array con nombres únicos de las apps
                for app in jsonArray! as! [NSDictionary] {
                    let name = app["name"] as! String
                    
                    if !(appRestricted.contains(name)) {
                        appRestricted.append(name)
                    }
                }
                
                let contenido = UNMutableNotificationContent()
                
                contenido.title = "Notificación de exceso"
                contenido.subtitle = "Ha excedido los tiempos limitados en:"
                contenido.body = appRestricted.joined(separator:" ")
                contenido.badge = 3
            }
        }
    }
    
    // método que marca el número de objetos que se van a mostrar
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (serverRetriever.nameArray.count)
    }
    
    // método que rellena los objetos con la información
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // establecimiento de la celda donde se va a meter la información
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCells", for: indexPath) as! AppCells
        
        // transformación del string obtenido en una url para localizar la imagen
        let url = URL(string: (serverRetriever.imageURLArray[indexPath.row]))
        
        // llenado de objetos do componentes de la celda
        cell.AppName.text = serverRetriever.nameArray[indexPath.row]
        cell.AppTime.text = serverRetriever.timeArray[indexPath.row]
        cell.AppIcon.af_setImage(withURL: url!)
        
        return cell
    }
    
    // método que responde a la selección de una app, llevando al usuario a un detalle de los tiempos de esta
    private func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // variable que indica el índice de la app señalada
        MainController.row = indexPath.row
        
        // cambio de pantalla al detalle de los tiempos de la app seleccionada
        performSegue(withIdentifier: "Detailing", sender: Any?.self)
    }
}
