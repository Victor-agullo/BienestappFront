//
//  File.swift
//  Bienestapp
//
//  Created by alumnos on 14/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import Alamofire

class HTTPMessenger {
    
    // con esta función se reciben los endpoints y se devuelve la URL necesaria
    func urlModder(direction: String) -> URL {
        
        let urlString = "http://localhost:8888/bienestapp/public/index.php/api/"
        
        let url = URL(string: urlString + direction)!
        
        return url
    }
    
    // el post para realizar el login o el register, se diferencia de los demás
    // en que no requiere de un token
    func logPost(endpoint: String, params: Dictionary<String, Any>) -> DataRequest{
        
        let url = urlModder(direction: endpoint)
        
        let post = Alamofire.request(url, method: .post, parameters: params)
        
        return post
    }
    
    // el post de información común, usa el token guardado en el UserDefaults
    func headPost(endpoint: String, params: Dictionary<String, Any>) -> DataRequest{
        let url = urlModder(direction: endpoint)
        
        let token = [
            "token" : UserDefaults.standard.value(forKey: "token")!
            ]as! [String:String]
        
        let post = Alamofire.request(url, method: .post, parameters: params, headers: token)
        
        return post
    }
    
    // pide información al servidor, identificando al usuario con el token en la cabecera
    func get(endpoint: String) -> DataRequest {
        
        let url = urlModder(direction: endpoint)
        
        let token = [
            "token" : UserDefaults.standard.value(forKey: "token")!
            ]as! [String:String]
        
        let get = Alamofire.request(url, method: .get, headers: token)
        
        return get
    }
    
    // guardado del token en userdefaults para tenerlo accesible en las demás peticiones
    func tokenSavior(response: DataResponse<Any>) {
        
        let token = jsonOpener(response: response)
        print(token)
        
        UserDefaults.standard.setValue(token["token"], forKey: "token")
    }
    
    // recibe el json con el token y lo transforma en un diccionario más manejable
    func jsonOpener(response: DataResponse<Any>) -> [String: Any] {
        let jsonToken = response.result.value!
        
        let object = jsonToken as! [String: Any]
        
        return object
    }
}
