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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let params = UserDefaults.standard.value(forKey: "user") {
            
            let login = HttpMessenger.post(endpoint: "login", params: [params])
            
            if login.self {
                self.performSegue(withIdentifier: "Logged", sender: UIStoryboardSegue.self)
            }
        }
    }

    @IBAction func senderButton(_ sender: UIButton) {
        let params = [
            "name" : nameEntry.text!,
            "email" : mailEntry.text!,
            "password" : passEntry.text!
        ]
        
        let url = URL(string: urlString+"register")!
        
        Alamofire.request(url, method: .post, parameters: params).responseJSON {
                (response) in
                if let json = response.result.value {
                    
                    let jsonParseado = json as! [String: Any]
                    
                    switch response.result {
                    case .success:
                        self.performSegue(withIdentifier: "Logged", sender: UIButton.self)
                        UserDefaults.standard.setValue(jsonParseado, forKey: "token")
                        UserDefaults.standard.setValue(params, forKey: "user")
                    case .failure:
                        print("invalidado")
                    }
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
