//
//  serverRetriever.swift
//  Bienestapp
//
//  Created by Víctor Agulló on 22/1/20.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit

class serverRetriever {
    
    // arrays que recogen las variables de distintos propósitos
    static var imageURLArray: Array<String> = []
    static var nameArray: Array<String> = []
    static var totalArray: Array<String> = []
    static var dayAvgArray: Array<String> = []
    static var weekAvgArray: Array<String> = []
    static var monthAvgArray: Array<String> = []
    static var timeArray: Array<String> = []
    static var dateArray: Array<Array<Dictionary<String, String>>> = []

    // método que obtiene los valores de los campos de la respuesta
    static func infoGatherer(thisCollectionView: UICollectionView, route: String) {
        
        // referencia a la clase encargada de gestionar las peticiones al server
        let HttpMessenger = HTTPMessenger()
        
        // array que almacena toda la respuesta del json
        var jsonArray: NSArray?
        
        // se realiza la petición de datos
        let get = HttpMessenger.get(endpoint: route)
        
        // obtención de la respuesta
        get.responseJSON { response in
            
            // guardado de la respuesta, de haberla, en una variable
            if let JSON = response.result.value {
                
                // conversión de la respuesta en un array y guardado de este
                jsonArray = JSON as? NSArray
                
                /*
                 bucle en el que se diferencian tres procesos:
                 · separación directa de los campos a obtener por índices
                 · obtención indirecta de los campos y diccionarios de registros de tiempos
                 · adición de ese valor obtenido a su correspondiente array
                */
                for item in jsonArray! as! [NSDictionary] {
                    
                    // separación directa de los campos a obtener por índices
                    let imageURL = item["icon"] as! String
                    let name = item["name"] as! String
                    let total = item["total"] as! String
                    let dayAvg = item["medio diario"] as! String
                    let weekAvg = item["medio semanal"] as! String
                    let monthAvg = item["medio mensual"] as! String
                    
                    // obtención indirecta de los campos y diccionarios de registros de tiempos
                    
                    // se ordenan todos los items recibidos, dejando en el medio de todos los
                    // valores los registros de tiempos
                    var timesOrdered = item.keysSortedByValue(using: #selector(NSNumber.compare(_:)))
                    
                    // obtención del tiempo total por vía indirecta
                    let timeToday = timesOrdered[3] as! String
                    let time = item[timeToday] as! String
                    
                    // elimina los tres primero y últimos valores
                    for _ in 1...3 {
                        timesOrdered.removeFirst()
                        timesOrdered.removeLast()
                    }
                    
                    // declaración de variables temporales para ordenar los tiempos
                    var timeFromDate: Dictionary<String, String>?
                    var container: Array<Dictionary<String, String>> = []
                    
                    // en el bucle se forman los diccionarios a partir del array
                    for index in timesOrdered {
                        
                        // separación del índice del array como key
                        let key:String = index as! String
                        
                        // y del valor como value
                        let value:String = item[index] as! String
                        
                        timeFromDate = [
                            key : value
                        ]
                        
                        container.append(timeFromDate!)
                    }
                    
                    // adición de cada valor obtenido a su correspondiente array
                    imageURLArray.append(imageURL)
                    nameArray.append(name)
                    totalArray.append(total)
                    dayAvgArray.append(dayAvg)
                    weekAvgArray.append(weekAvg)
                    monthAvgArray.append(monthAvg)
                    timeArray.append(time)
                    dateArray.append(container)
                }
                
                // se refresca el collectionView para colocar los valores
                thisCollectionView.reloadData()
            }
        }
    }
}
