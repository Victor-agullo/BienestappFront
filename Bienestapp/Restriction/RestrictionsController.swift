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
            if cell.isSelected {
                let cosa = cell.accessibilityValue!
                print(cosa)
        }
    }
    
    @IBAction func timePicker(_ sender: UIDatePicker) {
    }
    
    @IBAction func start_Time(_ sender: UIDatePicker) {
    }
    
    @IBAction func end_time(_ sender: UIDatePicker) {
    }
    
    
    @IBAction func time_sender(_ sender: UIButton) {
        let params = [
            "max_time" : self.maxTime,
            "start_at" : self.startTime,
            "finish_at" : self.endTime,
            "appName" : cellName
            ] as [String : Any]
        
        print(cellName)
        let _ = HttpMessenger.post(endpoint: "restricts", params: params)
    }
}
