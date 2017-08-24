//
//  Video.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/5/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Foundation

class Video {
    
    var name: String
    var thumbnail: String
    var url: String
    
    init(name: String, thumbnail: String, url: String) {
        
        self.name = name
        self.thumbnail = thumbnail
        self.url = url
    }
}
