//
//  TimelineItem.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/7/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Foundation

class TimelineItem {
    
    var id: Int
    var name: String
    var description: String
    var timeInMillis: Int
    
    init(id: Int, name: String, description: String, timeInMillis: Int) {
        
        self.id = id
        self.name = name
        self.description = description
        self.timeInMillis = timeInMillis
    }
}
