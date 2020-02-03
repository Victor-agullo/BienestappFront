//
//  TimeDetailApp.swift
//  Bienestapp
//
//  Created by alumnos on 30/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
import AlamofireImage

var timeKeys: Array<String> = []
var timeValues: Array<String> = []

class TimeDetailApp: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var imageApp: UIImageView!
    @IBOutlet weak var nameApp: UILabel!
    @IBOutlet weak var timeCollection: UICollectionView!
    
    var appTimes:[Dictionary<String, String>]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: imageURLArray[row!])
        imageApp.af_setImage(withURL: url!)
        
        nameApp.text = nameArray[row!]
        
        timeCollection.dataSource = self
        timeCollection.delegate = self
        
        var _ = datesGetter()
    }
    
    func datesGetter() -> [Dictionary<String, String>] {
        var timesPackaged: Array<[Dictionary<String, String>]> = []
        
        for date in dateArray {
            timesPackaged.append(date)
        }
        
        appTimes = timesPackaged[row!]
        
        return appTimes!
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appTimes!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        timeKeys.removeAll()
        timeValues.removeAll()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCells", for: indexPath) as! timeCells
        
        for item in appTimes!{
            
            for keys in item.keys {
                timeKeys.append(keys)
                continue
            }
            
            for values in item.values {
                timeValues.append(values)
                continue
            }
        }
        
        cell.time.text = timeValues[indexPath.row]
        cell.date.text = timeKeys[indexPath.row]
        return cell
    }
    
    @IBAction func statsButton(_ sender: Any) {
        performSegue(withIdentifier: "Stats", sender: Any?.self)
    }
}
