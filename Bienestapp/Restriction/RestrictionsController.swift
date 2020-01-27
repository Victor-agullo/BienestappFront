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
    
    @IBOutlet weak var maxTime: UIDatePicker!
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var endTime: UIDatePicker!
    @IBOutlet weak var restrictionView: UICollectionView!
    
    let goldColor = UIColor(red: 1, green: 185/255, blue: 21/255, alpha: 1)
    var HttpMessenger = HTTPMessenger()
    var cellName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maxTime.backgroundColor = goldColor
        startTime.backgroundColor = goldColor
        endTime.backgroundColor = goldColor
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restrictCells", for: indexPath) as! restrictCells
        
        cell.restrict_name.text = nameArray[indexPath.row]
        
        cellName = cell.restrict_name.text!
    }
    
    @IBAction func timePicker(_ sender: UIDatePicker) {}
    
    @IBAction func start_Time(_ sender: UIDatePicker) {}
    
    @IBAction func end_time(_ sender: UIDatePicker) {}
    
    func timeSetter() -> Dictionary<String, Any> {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let max_time = dateFormatter.string(from: self.maxTime.date).numberOfSeconds()
        let start_at = dateFormatter.string(from: self.startTime.date).numberOfSeconds()
        let finish_at = dateFormatter.string(from: self.endTime.date).numberOfSeconds()
        
        let params = [
            "appName" : cellName,
            "max_time" : max_time,
            "start_at" : start_at,
            "finish_at" : finish_at,
            ] as [String : Any]
        
        return params
    }
    
    @IBAction func time_sender(_ sender: UIButton) {
        let params = timeSetter()
        
        print(params)
        let _ = HttpMessenger.headPost(endpoint: "restricts", params: params)
    }
}

extension String {
    func numberOfSeconds() -> Int {
        var components: Array = self.components(separatedBy: ":")
        let hours = Int(components[0]) ?? 0
        let minutes = Int(components[1]) ?? 0
        let seconds = Int(components[2]) ?? 0
        return (hours * 3600) + (minutes * 60) + seconds
    }
}
