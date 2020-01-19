//
//  MainController.swift
//  Bienestapp
//
//  Created by alumnos on 09/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
class MainController:UIViewController, UICollectionViewDataSource {
    
    func infoGatherer() {
        
        HttpMessenger.get(endpoint: "times").responseJSON { response in
            let object = HttpMessenger.jsonOpener(response: response)
            
            print(object)
            
            let itemsInSection = object.count
            
            print(itemsInSection)
        }
    }
    
    let nombres: [String] = ["whasa", "feisbu", "insta", "chrome", "reloj", "google"]
    let tiempos: [String] = ["12:00", "13:00","para ya", "demasiado", "callate ya, hijo de puta", "que eres tontísimo"]
    let imagenes: [UIImage] = [#imageLiteral(resourceName: "morty"),#imageLiteral(resourceName: "rickgreen"),#imageLiteral(resourceName: "Rick-Morty"),#imageLiteral(resourceName: "mortycry"),#imageLiteral(resourceName: "rickgreen"),#imageLiteral(resourceName: "rick-horizontal")]
    
    @IBOutlet weak var AppCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoGatherer()
        AppCollection.dataSource = self
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagenes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCells", for: indexPath) as! AppCells
        
        cell.AppName.text = nombres[indexPath.row]
        cell.AppTime.text = tiempos[indexPath.row]
        cell.AppIcon.image = imagenes[indexPath.row]
        
        return cell
    }
}
