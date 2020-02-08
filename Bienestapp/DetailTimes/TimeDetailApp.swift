//
//  TimeDetailApp.swift
//  Bienestapp
//
//  Created by alumnos on 30/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
import AlamofireImage

class TimeDetailApp: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // referencias a los controladores necesarios en esta pantalla
    var mainView: MainController?
    var retrieved: serverRetriever?
    
    // variables que permiten el acceso a los tiempos y su fecha a todas las demás clases
    var timeKeys: Array<String> = []
    var timeValues: Array<String> = []

    // objetos de la pantalla
    @IBOutlet weak var imageApp: UIImageView!
    @IBOutlet weak var nameApp: UILabel!
    @IBOutlet weak var timeCollection: UICollectionView!
    
    // variable que recoge las apps en un diccionario de fecha : tiempo
    var appTimes:[Dictionary<String, String>]?
    
    // al cargar la pantalla se establecen los valores de la imagen y el nombre de la app seleccionada
    // y se realiza una llamada a
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // recepción y conversión del string recibido en la imagen de la app seleccionada
        let url = URL(string: (retrieved?.imageURLArray[(mainView?.row)!])!)
        imageApp.af_setImage(withURL: url!)
        
        // establece el nombre de la app según la app seleccionada en la pantalla anterior
        nameApp.text = retrieved?.nameArray[(mainView?.row)!]
        
        timeCollection.dataSource = self
        timeCollection.delegate = self
        
        // llamada a una función para que se obtenga el diccionario de fechas y tiempos
        // de la app seleccionada
        var _ = datesGetter()
    }
    
    func datesGetter() -> [Dictionary<String, String>] {
        // creación de un array de diccionarios donde guardar los strings de tiempos
        var timesPackaged: Array<[Dictionary<String, String>]> = []
        
        // bucle que abre el array de arrays de diccionarios
        for date in (retrieved?.dateArray)! {
            // guardado de diccionarios en un array
            timesPackaged.append(date)
        }
        
        // obtención del diccionario que se requiere
        appTimes = timesPackaged[(mainView?.row)!]
        
        return appTimes!
    }
    
    // método que marca el número de objetos que se van a mostrar
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appTimes!.count
    }
    
    // método que rellena los objetos con la información
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // elimina todo el contenido de los arrays para que no haya contaminación cruzada
        timeKeys.removeAll()
        timeValues.removeAll()
        
        // establecimiento de la celda donde se va a meter la información
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCells", for: indexPath) as! timeCells
        
        // apertura del diccionario para la obtención de cada fecha (key) y tiempo de uso (valor)
        for item in appTimes!{
            
            // dado que se va a ejecutar el mismo número de veces que el for padre
            // más las veces de cada valor que exista para cada uno y sólo se
            // requiere un valor de cada, en cada ciclo que se obtiene el dato
            // deseado se salta al siguiente.
            for keys in item.keys {
                timeKeys.append(keys)
                continue
            }
            
            for values in item.values {
                timeValues.append(values)
                continue
            }
        }
        
        cell.time.text = timeValues[indexPath.row]
        cell.date.text = timeKeys[indexPath.row]
        
        return cell
    }
    
    // un botón que dirige a la pantalla de estadísticas
    @IBAction func statsButton(_ sender: Any) {
        performSegue(withIdentifier: "Stats", sender: Any?.self)
    }
}
