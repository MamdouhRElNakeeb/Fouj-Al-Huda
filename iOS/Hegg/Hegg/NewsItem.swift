//
//  NewsItem.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/7/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Foundation

class NewsItem {
    
    var id: Int
    var title: String
    var description: String
    var image: String
    var timeInMillis: Int
    
    init(id: Int, title: String, description: String, image: String, timeInMillis: Int) {
        
        self.id = id
        self.title = title
        self.description = description
        self.image = image
        self.timeInMillis = timeInMillis
    }
}
