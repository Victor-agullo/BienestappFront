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
    
    func post(endpoint:String, params: Dictionary<String, Any>) -> Int {

        let url = urlModder(endpoint: endpoint)
        
        var code = Alamofire.request(url, method: .post, parameters: params).validate().response {
            response in response.response?.statusCode
            }
        
        return
        }
    }
    
    func urlModder(endpoint: String) -> URL {
        let url = URL(string: urlString+"login")!
    }
}
