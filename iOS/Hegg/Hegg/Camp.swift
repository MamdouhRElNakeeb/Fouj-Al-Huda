//
//  Camp.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/6/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Foundation

class Camp {
    
    var id: Int = 0
    var name: String = ""
    var latitude: Double = 0
    var longitude: Double = 0
    var description: String = ""
    
    init(id: Int, name: String, latitude: Double, longitude: Double, description: String) {
        
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.description = description
    }
    
    init() {
        
    }
}
