//
//  ViewController.swift
//  Bienestapp
//
//  Created by alumnos on 08/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
import Alamofire

class LoginController: UIViewController {

    @IBOutlet weak var nameEntry: UITextField!
    @IBOutlet weak var mailEntry: UITextField!
    @IBOutlet weak var passEntry: UITextField!
    
    var urlString = "http://localhost:8888/bienestapp/public/index.php/api/register"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func senderButton(_ sender: UIButton) {
        let params = [
            "name" : nameEntry.text!,
            "email" : mailEntry.text!,
            "password" : passEntry.text!
        ]
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON(completionHandler: { (response) in
            if (response.result.value != nil) {
                
            }
        })
    }
    
}

