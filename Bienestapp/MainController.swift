//
//  MainController.swift
//  Bienestapp
//
//  Created by alumnos on 09/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
class MainController:UIViewController, UICollectionViewDataSource {
    
    func infoGatherer() -> Array<Any> {
        //Un get
        HttpMessenger.post(endpoint: <#T##String#>, params: <#T##Any#>)
        
        let some: [String] = ["",""]
        return some
    }
    
    @IBOutlet weak var collectionOfApps: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionOfApps.dataSource = self
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionAppCells", for: indexPath) as! AppCells
        
        //cell.appName.text = array[indexPath.row]
        cell.AppName.text = array[indexPath.row]
        
        return cell
    }
}
