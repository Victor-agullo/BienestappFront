//
//  serverRetriever.swift
//  Bienestapp
//
//  Created by Víctor Agulló on 22/1/20.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit

// se declaran fuera de la clase para que sean unas variables publicas y accesibles
var nameArray: Array<String> = []
var optionsArray: Array<String> = []
var imageURLArray: Array<String> = []

class serverRetriever: UIViewController {
    
    // array genérico para meter la respuesta del get
    var jsonArray: NSArray?
    
    // llamada al gestor de respuestas
    var HttpMessenger = HTTPMessenger()

    // tras pedir información al server, la traduce a Arrays y luego los guarda en divisiones
    func infoGatherer(thisCollectionView: UICollectionView) {
        
        // realiza el get
        let get = self.HttpMessenger.get(endpoint: "times")
        
        // recoge la respuesta
        get.responseJSON { response in
            
            // se cerciona de que haya respuesta
            if let JSON = response.result.value {
                
                // pasa el JSON a array
                self.jsonArray = JSON as? NSArray
                
                // bucle que desgrana el array del JSON en los arrays que necesitamos según
                // el índice de
                for item in self.jsonArray! as! [NSDictionary] {
                    
                    let name = item["name"] as! String
                    let imageURL = item["icon"] as! String
                    let options = item["options"] as! String
                    
                    nameArray.append(name)
                    optionsArray.append(options)
                    imageURLArray.append(imageURL)
                }
                // recarga la vista para hacer efectivos los cambios
                thisCollectionView.reloadData()
            }
        }
    }
}
