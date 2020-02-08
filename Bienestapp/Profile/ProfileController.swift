//
//  ProfileController.swift
//  Bienestapp
//
//  Created by alumnos on 28/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
import UserNotifications

class ProfileController: UIViewController {
    
    // referencias a los controladores necesarios en esta pantalla
    var mainView: MainController?
    
    // referencias a los botones de notifications y messages
    @IBOutlet weak var notifications: UIButton!
    @IBOutlet weak var messages: UIButton!
    
    // variable para el envío de mensajes desde la api al correo
    var reversed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // botón que avisa al usuario del estado de disposición de las notificaciones
    // y permite activarlas o desactivarlas con pulsarlo
    @IBAction func notificationsButt(_ sender: UIButton) {
        // al pulsar el botón se cambia el valor del permiso de notifications
        mainView?.auth!.toggle()
        
        // con el valor cambiado se cambia también el color del botón
        switcher(object: notifications, flag: (mainView?.auth)!)
    }
    
    // botón que avisa al usuario del estado de disposición de la mensajería
    // y permite activarlas o desactivarlas con pulsarlo
    @IBAction func messagesAllowance(_ sender: UIButton) {
        // al pulsar el botón se cambia el valor del permiso de mensajes
        reversed.toggle()
        
        // con el valor cambiado se cambia también el color del botón
        switcher(object: messages, flag: reversed)
    }
    
    // función que recoge una booleana y un botón para que,
    // según su valor, se cambie de color el botón
    func switcher(object: UIButton, flag: Bool) {
        if flag {
            // como la función del color necesita estar en el hilo principal,
            // se llama a usar una cola asíncrona
            DispatchQueue.main.async {
                object.setTitleColor(UIColor.purple, for: UIControl.State.normal)
            }
        } else {
            DispatchQueue.main.async {
                object.setTitleColor(UIColor.black, for: UIControl.State.normal)
            }
        }
    }
}
