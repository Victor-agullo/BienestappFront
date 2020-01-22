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

    func urlModder(direction: String) -> URL {
        let urlString = "http://localhost:8888/bienestapp/public/index.php/api/"

        let url = URL(string: urlString+direction)!
        
        return url
    }
    
    func post(endpoint: String, params: Any) -> DataRequest{
        
        let url = urlModder(direction: endpoint)
        
        let post = Alamofire.request(url, method: .post, parameters: params as? Parameters)
        
        return post
    }
    
    func get(endpoint: String) -> DataRequest {
        
        let url = urlModder(direction: endpoint)
        
        let token = [
            "token" : UserDefaults.standard.value(forKey: "token")!
        ]as! [String:String]
        
        let get = Alamofire.request(url, method: .get, headers: token)

        return get
    }
    
    func tokenSavior(response: DataResponse<Any>) {
        
        let token = jsonOpener(response: response)
        
        UserDefaults.standard.set(token["token"], forKey: "token")
    }
    
    func jsonOpener(response: DataResponse<Any>) -> [String: Any] {
        let jsonToken = response.result.value!
        
        let object = jsonToken as! [String: Any]
        
        return object
    }
}
