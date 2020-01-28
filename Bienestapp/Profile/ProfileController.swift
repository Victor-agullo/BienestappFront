//
//  ProfileController.swift
//  Bienestapp
//
//  Created by alumnos on 28/01/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var notifications: UIButton!
    @IBOutlet weak var messages: UIButton!
    var pressed = true
    var reversed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func notificationsButt(_ sender: UIButton) {
        if pressed {
            notifications.setTitleColor(UIColor.purple, for: UIControl.State.normal)
        } else {
            notifications.setTitleColor(UIColor.black, for: UIControl.State.normal)
        }
        pressed.toggle()
    }
    
    @IBAction func messagesAllowance(_ sender: UIButton) {
        if reversed {
            messages.setTitleColor(UIColor.purple, for: UIControl.State.normal)
        } else {
            messages.setTitleColor(UIColor.black, for: UIControl.State.normal)
        }
        reversed.toggle()
    }
}
