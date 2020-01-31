//
//  TimeDetailApp.swift
//  Bienestapp
//
//  Created by alumnos on 30/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
import AlamofireImage

class TimeDetailApp: UIViewController {
    @IBOutlet weak var imageApp: UIImageView!
    @IBOutlet weak var nameApp: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: imageURLArray[row])
        imageApp.af_setImage(withURL: url!)
        
        nameApp.text = nameArray[row]
    }
}
