//
//  serverRetriever.swift
//  Bienestapp
//
//  Created by Víctor Agulló on 22/1/20.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit

class serverRetriever {
    
    var imageURLArray: Array<String> = []
    var nameArray: Array<String> = []
    var totalArray: Array<String> = []
    var dayAvgArray: Array<String> = []
    var weekAvgArray: Array<String> = []
    var monthAvgArray: Array<String> = []
    var timeArray: Array<String> = []
    var dateArray: Array<Array<Dictionary<String, String>>> = []

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
                    let dayAvg = item["medio diario"] as! String
                    let weekAvg = item["medio semanal"] as! String
                    let monthAvg = item["medio mensual"] as! String
                    
                    var timesOrdered = item.keysSortedByValue(using: #selector(NSNumber.compare(_:)))
                    let timeToday = timesOrdered[3] as! String
                    let time = item[timeToday] as! String
                    
                    self.imageURLArray.append(imageURL)
                    self.nameArray.append(name)
                    self.totalArray.append(total)
                    self.dayAvgArray.append(dayAvg)
                    self.weekAvgArray.append(weekAvg)
                    self.monthAvgArray.append(monthAvg)
                    self.timeArray.append(time)
                    
                    timesOrdered.removeFirst()
                    timesOrdered.removeFirst()
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
                    self.dateArray.append(container)
                }
                thisCollectionView.reloadData()
            }
        }
    }
}
