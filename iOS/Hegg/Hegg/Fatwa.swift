//
//  Fatwa.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/11/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Foundation

class Fatwa {
    
    var question: String = ""
    var answer: String = ""
    
    init(question: String, answer: String) {
        
        self.question = question
        self.answer = answer
    }
    
    init(){
        
    }
    
}
