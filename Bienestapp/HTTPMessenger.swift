//
//  File.swift
//  Bienestapp
//
//  Created by alumnos on 14/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
import Alamofire

var HttpMessenger = HTTPMessenger()

class HTTPMessenger {
    
    let urlString = "http://localhost:8888/bienestapp/public/index.php/api/"
    
    func urlModder(direction: String) -> URL {
        
        let url = URL(string: urlString+direction)!
        
        return url
    }
    
    func postBool(endpoint: String, params: Any) -> Bool{
        
        let url = urlModder(direction: endpoint)
        
        if Alamofire.request(url, method: .post, parameters: params as? Parameters).responseJSON { response in
                switch response.result {
                case .success:
                    if endpoint == "login"{
                        self.tokenChecker(response: response)
                    } else if endpoint == "register"{
                        UserDefaults.standard.setValue(params, forKey: "user")
                    }
                case .failure:
                    break
                }
            } {
            
        }
    }
    
    func post(endpoint: String, params: Any) {
        
        let url = urlModder(direction: endpoint)
        
        Alamofire.request(url, method: .post, parameters: params as? Parameters)
    }
    
    func tokenChecker(response: DataResponse<Any>) {
        
        let jsonToken = response.result.value!
        
        let token = jsonToken as! [String: Any]
        
        UserDefaults.standard.setValue(token["token"], forKey: "token")
    }
    
}
