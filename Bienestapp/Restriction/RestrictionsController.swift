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
    
    @IBOutlet weak var restrictCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restrictCollection.dataSource = self
        restrictCollection.delegate = self
    }

    var jsonArray: NSArray?
    var nameArray: Array<String> = []
    var timeArray: Array<String> = []
    var imageURLArray: Array<String> = []
    
    func infoGatherer(thisCollectionView: UICollectionView) {
        
        let get = HttpMessenger.get(endpoint: "times")
        
        get.responseJSON { response in
            
            if let JSON = response.result.value {
                
                self.jsonArray = JSON as? NSArray
                
                for item in self.jsonArray! as! [NSDictionary] {
                    
                    let name = item["name"] as! String
                    let imageURL = item["icon"] as! String
                    
                    var timesOrdered = item.keysSortedByValue(using: #selector(NSNumber.compare(_:)))
                    let timeToday = timesOrdered[1] as! String
                    let time = item[timeToday] as! String
                    
                    self.nameArray.append(name)
                    self.timeArray.append(time)
                    self.imageURLArray.append(imageURL)
                }
                
                thisCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restrictCells", for: indexPath) as! restrictCells
        
        let url = URL(string: self.imageURLArray[indexPath.row])
        
        cell.restrictedName.text = nameArray[indexPath.row]
        cell.restrictedIcon.af_setImage(withURL: url!)
        
        return cell
    }
}
