//
//  serverRetriever.swift
//  Bienestapp
//
//  Created by Víctor Agulló on 22/1/20.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
import AlamofireImage

var retriever = serverRetriever()

class serverRetriever {
    
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
                print(self.nameArray)
            }
            print(self.nameArray)
        }
        print(self.nameArray)
    }
}
