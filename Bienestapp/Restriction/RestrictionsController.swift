//
//  RestrictionsController.swift
//  Bienestapp
//
//  Created by Víctor Agulló on 22/1/20.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
import AlamofireImage

class RestrictionController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    // referencias a los controladores necesarios en esta pantalla
    var retrieved: serverRetriever?
    
    // referencia a los objetos de la pantalla selectores de fechas y a la vista dentro de la que se
    // ponen las aplicaciones disponibles para seleccionar una restriccion
    @IBOutlet weak var restrictionView: UICollectionView!
    @IBOutlet weak var maxTime: UIDatePicker!
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var endTime: UIDatePicker!
    
    //color de los selectores
    let goldColor = UIColor(red: 1, green: 185/255, blue: 21/255, alpha: 1)
    
    // referencia a la clase httpmessenger
    var HttpMessenger = HTTPMessenger()
    
    // variable de inicialización de el nombre de la celda
    var cellName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // coloreado de los elementos interactuables de la vista
        maxTime.backgroundColor = goldColor
        startTime.backgroundColor = goldColor
        endTime.backgroundColor = goldColor
        
        restrictionView.dataSource = self
        restrictionView.delegate = self
    }
    
    // método que marca el número de objetos que se van a mostrar
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (retrieved?.nameArray.count)!
    }
    
    // método que rellena los objetos con la información
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restrictCells", for: indexPath) as! restrictCells
        let url = URL(string: (retrieved?.imageURLArray[indexPath.row])!)
        
        cell.restrict_name.text = retrieved?.nameArray[indexPath.row]
        cell.restrict_image.af_setImage(withURL: url!)
        
        return cell
    }
    
    // método que rellena la referencia al nombre de la app con la información
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restrictCells", for: indexPath) as! restrictCells
        
        cell.restrict_name.text = retrieved?.nameArray[indexPath.row]
        
        cellName = cell.restrict_name.text!
    }
    
    //objetos necesarios para que se permita su uso programático
    @IBAction func timePicker(_ sender: UIDatePicker) {}
    @IBAction func start_Time(_ sender: UIDatePicker) {}
    @IBAction func end_time(_ sender: UIDatePicker) {}
    
    //método que recopila toda la información y la prepara para su envío
    func timeSetter() -> Dictionary<String, Any> {
        
        // presentación del formato del tiempo
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        // transformación del tiempo obtenido por los datepicker en segundos
        let max_time = dateFormatter.string(from: self.maxTime.date).numberOfSeconds()
        let start_at = dateFormatter.string(from: self.startTime.date).numberOfSeconds()
        let finish_at = dateFormatter.string(from: self.endTime.date).numberOfSeconds()
        
        // preparado del diccionario que se mandará al servidor
        let params = [
            "appName" : cellName,
            "max_time" : max_time,
            "start_at" : start_at,
            "finish_at" : finish_at,
            ] as [String : Any]
        
        return params
    }
    
    // botón que al pulsarse envía los datos recogidos al servidor para su almacenamiento
    @IBAction func time_sender(_ sender: UIButton) {
        let params = timeSetter()
        
        print(params)
        let _ = HttpMessenger.headPost(endpoint: "restricts", params: params)
    }
}
