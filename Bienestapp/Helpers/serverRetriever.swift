//
//  serverRetriever.swift
//  Bienestapp
//
//  Created by Víctor Agulló on 22/1/20.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit

var imageURLArray: Array<String> = []
var nameArray: Array<String> = []
var totalArray: Array<String> = []
var avgArray: Array<String> = []
var timeArray: Array<String> = []
var dateArray: Array<Array<Dictionary<String, String>>> = []

class serverRetriever {
    
    var jsonArray: NSArray?
    
    var HttpMessenger = HTTPMessenger()
    
    func infoGatherer(thisCollectionView: UICollectionView, route: String) {
        
        let get = self.HttpMessenger.get(endpoint: route)
        
        get.responseJSON { response in
            
            if let JSON = response.result.value {
                
                self.jsonArray = JSON as? NSArray
                
                for item in self.jsonArray! as! [NSDictionary] {
                    
                    let imageURL = item["icon"] as! String
                    let name = item["name"] as! String
                    let total = item["total"] as! String
                    let avg = item["medio total"] as! String
                    
                    var timesOrdered = item.keysSortedByValue(using: #selector(NSNumber.compare(_:)))
                    let timeToday = timesOrdered[1] as! String
                    let time = item[timeToday] as! String
                    
                    imageURLArray.append(imageURL)
                    nameArray.append(name)
                    totalArray.append(total)
                    avgArray.append(avg)
                    timeArray.append(time)
                    
                    timesOrdered.removeFirst()
                    timesOrdered.removeLast()
                    timesOrdered.removeLast()
                    timesOrdered.removeLast()
                    
                    var timeFromDate: Dictionary<String, String>?
                    var container: Array<Dictionary<String, String>> = []
                    
                    for index in timesOrdered {
                        let key:String = index as! String
                        let value:String = item[index] as! String
                        
                        timeFromDate = [
                            key : value
                        ]
                        
                        container.append(timeFromDate!)
                    }
                    dateArray.append(container)
                }
                thisCollectionView.reloadData()
            }
        }
    }
}
