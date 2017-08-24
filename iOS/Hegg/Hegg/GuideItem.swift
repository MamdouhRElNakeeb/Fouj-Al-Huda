//
//  GuideItem.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/19/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Foundation

class GuideItem {
    
    var id: Int = 0
    var name: String = ""
    var imageURL: String = ""
    var pdfURL: String = ""
    
    init(id: Int, name: String, imageURL: String, pdfURL: String) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.pdfURL = pdfURL
    }
    
    init() {
        
    }
}
