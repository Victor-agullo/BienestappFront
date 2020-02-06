//
//  ViewController.swift
//  Bienestapp
//
//  Created by alumnos on 08/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    // declaración de todas las entradas de datos
    @IBOutlet weak var nameEntry: UITextField!
    @IBOutlet weak var mailEntry: UITextField!
    @IBOutlet weak var passEntry: UITextField!
    
    //Inicialización y recordatorio del contacto con la clase que gestiona las peticiones HTTP
    var HttpMessenger = HTTPMessenger()
    
    // Al iniciar la app, se intentará hacer un inicio de sesión con el usuario guardado, de haberlo
    override func viewDidAppear(_ animated: Bool) {
        
        // busca un "user" guardado
        if var data = UserDefaults.standard.dictionary(forKey: "user") {
            
            //si lo hay, recoge el documento csv que recopila los usos de las apps
            let file = usagesProvider()
            
            // lo añade al diccionario que es el "user"
            data["csvFile"] = file
            
            // y manda el resultado para el login
            viewJumper(parameters: data, uri: "login")
        }
    }
    
    // crea un link en los directorios del teléfono para crear una dirección 
    func usagesProvider() -> URL {
        
        // nombre del archivo al que se creará el vínculo simbólico
        let name = "usage.csv"
        
        // proceso de formación del link en el directorio Document
        let directory = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
        
        // generación de la ruta
        let rute = directory.first?.appendingPathComponent(name)
        print(rute!)
        return rute!
    }
    
    // botón de registro que obtiene el archivo csv, los parámetros e
    // inicia la petición.
    @IBAction func registerButton(_ sender: UIButton) {
        let file = usagesProvider()
        
        let params = getParams(file: file)
        
        viewJumper(parameters: params, uri: "register")
    }
    
    // botón de login que obtiene el archivo csv, los parámetros e
    // inicia la petición.
    @IBAction func loginButton(_ sender: UIButton) {
        let file = usagesProvider()
        
        let params = getParams(file: file)
        
        viewJumper(parameters: params, uri: "login")
    }
    
    // método que recoge toda la información y la prepara en el diccionario params
    func getParams(file: URL) -> Dictionary<String, Any> {
        
        let params = [
            "name" : nameEntry.text!,
            "email" : mailEntry.text!,
            "password" : passEntry.text!,
            "csvFile" : file
            ] as [String : Any]
        
        return params
    }
    
    // método que resuelve las peticiones de login y el registro, si son
    // satisfactorias realiza la entrada a la app
    func viewJumper(parameters: Dictionary<String, Any>, uri: String) {
        // se crea una variable para que los senders sean todos el mismo
        let from = Any?.self
        
        // recepción de la respuesta del post para el login
        let hadConnected = HttpMessenger.logPost(endpoint: uri, params: parameters)
        
        // según el endpoint, se realizarán diferentes rutas y acciones
        hadConnected.responseJSON { response in
            
            switch response.result {
                
            case .success:
                
                if uri == "login"{
                    // al ser un login, se recoge la respuesta para obtener el token
                    self.HttpMessenger.tokenSavior(response: response)
                    
                    // si todo sale bien, se realiza el segue
                    self.performSegue(withIdentifier: "Logged", sender: from)
                    
                } else if uri == "register" {
                    
                    // para modificar los parámetros se convierte la constante en variable
                    var params = parameters
                    
                    // el csv no es necesario guardarlo ya que no es un archivo inmutable
                    params.removeValue(forKey: "csvFile")
                    
                    // se guarda el formato válido en userdefaults
                    UserDefaults.standard.set(params, forKey: "user")
                    
                    // si todo sale bien, se realiza el segue
                    self.performSegue(withIdentifier: "Logged", sender: from)
                }
                
            case .failure:
                
                // para facilitar la resolución de errores se imprime "fallo" si no
                // se alcanza a realizar la conexión con éxito
                print("fallo")
                break
            }
        }
    }
    
    // un método sencillo que recoge los datos de nombre y email ignorando la contraseña
    // que precisamente se cambiará y devolverá por el email correspondiente al usuario que coincida
    @IBAction func passRecovery(_ sender: UIButton) {
        let params = [
            "name" : nameEntry.text!,
            "email" : mailEntry.text!,
        ]
        
        let _ = HttpMessenger.logPost(endpoint: "forgot", params: params)
    }
}
