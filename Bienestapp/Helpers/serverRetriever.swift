//
//  serverRetriever.swift
//  Bienestapp
//
//  Created by Víctor Agulló on 22/1/20.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit

var nameArray: Array<String> = []
var timeArray: Array<String> = []
var imageURLArray: Array<String> = []

class serverRetriever {
    
    var jsonArray: NSArray?
    var HttpMessenger = HTTPMessenger()
    
    func infoGatherer(thisCollectionView: UICollectionView, route: String) {
        
        let get = self.HttpMessenger.get(endpoint: route)
        
        get.responseJSON { response in
            
            if let JSON = response.result.value {
                
                self.jsonArray = JSON as? NSArray
                
                for item in self.jsonArray! as! [NSDictionary] {
                    print(self.jsonArray!)
                    let name = item["name"] as! String
                    let imageURL = item["icon"] as! String
                    
                    var timesOrdered = item.keysSortedByValue(using: #selector(NSNumber.compare(_:)))
                    let timeToday = timesOrdered[1] as! String
                    let time = item[timeToday] as! String
                    
                    nameArray.append(name)
                    timeArray.append(time)
                    imageURLArray.append(imageURL)
                }
                thisCollectionView.reloadData()
            }
        }
    }
}
