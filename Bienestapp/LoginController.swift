//
//  ViewController.swift
//  Bienestapp
//
//  Created by alumnos on 08/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var nameEntry: UITextField!
    @IBOutlet weak var mailEntry: UITextField!
    @IBOutlet weak var passEntry: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        if let params = UserDefaults.standard.value(forKey: "user") {
            
            viewJumper(parameters: params, uri: "login", from: Any?.self)
        }
    }
    
    @IBAction func senderButton(_ sender: UIButton) {
        let params = [
            "name" : nameEntry.text!,
            "email" : mailEntry.text!,
            "password" : passEntry.text!
        ]
        
        viewJumper(parameters: params, uri: "register", from: Any?.self)
    }
    
    func viewJumper(parameters: Any, uri: String, from: Any) {
        
        HttpMessenger.postBool(endpoint: uri, params: parameters)
        
        performSegue(withIdentifier: "Logged", sender: from)
    }
    
    @IBAction func passRecovery(_ sender: UIButton) {
        let params = [
            "name" : nameEntry.text!,
            "email" : mailEntry.text!,
        ]
        
        HttpMessenger.post(endpoint: "forgot", params: params)
    }
}
