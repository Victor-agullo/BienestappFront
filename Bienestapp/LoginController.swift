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
    
    var urlString = "http://localhost:8888/bienestapp/public/index.php/api/"
    let sessionManager = Alamofire.SessionManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let params = [
            "name" : nameEntry.text!,
            "email" : mailEntry.text!,
            "password" : passEntry.text!
        ]
        let url = URL(string: urlString+"login")!
        
        Alamofire.request(url, method: .post, parameters: params)
    }

    @IBAction func senderButton(_ sender: UIButton) {
        let params = [
            "name" : nameEntry.text!,
            "email" : mailEntry.text!,
            "password" : passEntry.text!
        ]
        
        let url = URL(string: urlString+"register")!
        
        Alamofire.request(
                url,
                method: .post,
                parameters: params
            ).responseJSON {
                (response) in
                if let json = response.result.value {
                    
                    let jsonParseado = json as! [String: Any]
                    
                    UserDefaults.standard.setValue(jsonParseado, forKey: "token")
                    UserDefaults.standard.synchronize()
            }
        }
        
 
    }
    
    @IBAction func passRecovery(_ sender: UIButton) {
        let params = [
            "name" : nameEntry.text!,
            "email" : mailEntry.text!,
        ]
        let url = URL(string: urlString+"forgot")!
        Alamofire.request(url, method: .post, parameters: params)
    }
}
