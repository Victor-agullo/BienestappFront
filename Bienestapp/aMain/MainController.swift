//
//  MainController.swift
//  Bienestapp
//
//  Created by alumnos on 09/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
import AlamofireImage

class MainController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var AppCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppCollection.dataSource = self
        AppCollection.delegate = self
        serverRetriever.init().infoGatherer(thisCollectionView: AppCollection)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCells", for: indexPath) as! AppCells
        let url = URL(string: imageURLArray[indexPath.row])
        
        cell.AppName.text = nameArray[indexPath.row]
        cell.AppTime.text = timeArray[indexPath.row]
        cell.AppIcon.af_setImage(withURL: url!)
        
        return cell
    }
}
