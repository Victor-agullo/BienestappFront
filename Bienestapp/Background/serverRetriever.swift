//
//  serverRetriever.swift
//  Bienestapp
//
//  Created by Víctor Agulló on 22/1/20.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit

var nameArray: Array<String> = []
var optionsArray: Array<String> = []
var imageURLArray: Array<String> = []

class serverRetriever: UIViewController {
    
    var jsonArray: NSArray?
    var HttpMessenger = HTTPMessenger()

    func infoGatherer(thisCollectionView: UICollectionView) {
        
        let get = self.HttpMessenger.get(endpoint: "times")
        
        get.responseJSON { response in
            
            if let JSON = response.result.value {
                
                self.jsonArray = JSON as? NSArray
                
                for item in self.jsonArray! as! [NSDictionary] {
                    
                    let name = item["name"] as! String
                    let imageURL = item["icon"] as! String
                    let options = item["options"] as! String
                    
                    nameArray.append(name)
                    optionsArray.append(options)
                    imageURLArray.append(imageURL)
                }
                thisCollectionView.reloadData()
            }
        }
    }
}
