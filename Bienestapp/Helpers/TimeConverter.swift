//
//  TimeConverter.swift
//  Bienestapp
//
//  Created by alumnos on 05/02/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//

extension String {
    func numberOfSeconds() -> Int {
        var components: Array = self.components(separatedBy: ":")
        let hours = Int(components[0]) ?? 0
        let minutes = Int(components[1]) ?? 0
        let seconds = Int(components[2]) ?? 0
        return (hours * 3600) + (minutes * 60) + seconds
    }
}
