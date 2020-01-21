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
        
        if var data = UserDefaults.standard.dictionary(forKey: "user") {
            let file = usagesProvider()
            
            data["csvFile"] = file
            viewJumper(parameters: data, uri: "login")
        }
    }
    
    func usagesProvider() -> URL {
        
        let name = "usage.csv"
        
        let directory = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
        let rute = directory.first?.appendingPathComponent(name)

        return rute!
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        let file = usagesProvider()
        
        let params = [
            "name" : nameEntry.text!,
            "email" : mailEntry.text!,
            "password" : passEntry.text!,
            "csvFile" : file
            ] as [String : Any]
        
        viewJumper(parameters: params, uri: "register")
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        let file = usagesProvider()
        
        let params = [
        "name" : nameEntry.text!,
        "email" : mailEntry.text!,
        "password" : passEntry.text!,
        "csvFile" : file
            ] as [String : Any]
        
        viewJumper(parameters: params, uri: "login")
    }
    
    func viewJumper(parameters: Any, uri: String) {
        
        let from = Any?.self
        
        let hadConnected = HttpMessenger.post(endpoint: uri, params: parameters)
        
        hadConnected.responseJSON { response in
            
            switch response.result {
                
            case .success:
                
                if uri == "login"{
                    HttpMessenger.tokenSavior(response: response)
                    self.performSegue(withIdentifier: "Logged", sender: from)
                    
                } else if uri == "register" {
                    UserDefaults.standard.set(parameters, forKey: "user")
                    self.performSegue(withIdentifier: "Logged", sender: from)
                }
                
            case .failure:
                print("fallo")
                break
            }
        }
    }
    
    @IBAction func passRecovery(_ sender: UIButton) {
        let params = [
            "name" : nameEntry.text!,
            "email" : mailEntry.text!,
        ]
        
        let _ = HttpMessenger.post(endpoint: "forgot", params: params)
    }
}
