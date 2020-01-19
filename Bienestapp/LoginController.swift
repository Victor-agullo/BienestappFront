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
    
    let file = Bundle.main.path(forResource: "usage", ofType: "csv")
    
    override func viewDidAppear(_ animated: Bool) {
        if var params = UserDefaults.standard.value(forKey: "user") as? Dictionary<String, Any> {

            params["csvFile"] = file
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
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        let params = [
        "name" : nameEntry.text!,
        "email" : mailEntry.text!,
        "password" : passEntry.text!,
        "csvFile" : file
        ]
        
        viewJumper(parameters: params, uri: "login", from: Any?.self)
    }
    func viewJumper(parameters: Any, uri: String, from: Any) {
        
        let hadConnected = HttpMessenger.post(endpoint: uri, params: parameters)
        
        hadConnected.responseJSON { response in
            
            switch response.result {
                
            case .success:
                
                if uri == "login"{
                    HttpMessenger.tokenSavior(response: response)
                    
                } else if uri == "register"{
                    UserDefaults.standard.setValue(parameters, forKey: "user")
                }
                self.performSegue(withIdentifier: "Logged", sender: from)
                
            case .failure:
                break
            }
        }
    }
    
    @IBAction func passRecovery(_ sender: UIButton) {
        let params = [
            "name" : nameEntry.text!,
            "email" : mailEntry.text!,
        ]
        
        HttpMessenger.post(endpoint: "forgot", params: params)
    }
}
