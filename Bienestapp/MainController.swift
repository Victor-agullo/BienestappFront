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
    
    var jsonArray: NSArray?
    var nameArray: Array<String> = []
    var timeArray: Array<String> = []
    var imageURLArray: Array<String> = []
    
    @IBOutlet weak var AppCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppCollection.dataSource = self
        AppCollection.delegate = self
        infoGatherer()
    }
    
    func infoGatherer() {
        
        let get = HttpMessenger.get(endpoint: "times")
        
            get.responseJSON { response in
            if let JSON = response.result.value{
                
                self.jsonArray = JSON as? NSArray
                print(JSON)
                for item in self.jsonArray! as! [NSDictionary]{
                    
                    let name = item["name"] as? String
                    print(name!)
                    let imageURL = item["icon"] as? String
                    print(imageURL!)
                    let timeToday = item["0"] as? String
                    print(timeToday!)
                    self.nameArray.append((name)!)
                    self.timeArray.append((timeToday)!)
                    self.imageURLArray.append((imageURL)!)
                }
                self.AppCollection.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCells", for: indexPath) as! AppCells
        let url = URL(string: self.imageURLArray[indexPath.row])
        
        cell.AppName.text = nameArray[indexPath.row]
        cell.AppTime.text = timeArray[indexPath.row]
        cell.AppIcon.af_setImage(withURL: url!)
        
        return cell
    }
}
