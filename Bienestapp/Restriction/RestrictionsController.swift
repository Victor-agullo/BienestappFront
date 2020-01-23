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
    
    @IBOutlet weak var restrictionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restrictionView.dataSource = self
        restrictionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restrictCells", for: indexPath) as! restrictCells
        let url = URL(string: imageURLArray[indexPath.row])
        
        cell.restrict_name.text = nameArray[indexPath.row]
        cell.restrict_image.af_setImage(withURL: url!)
        
        return cell
    }
}
