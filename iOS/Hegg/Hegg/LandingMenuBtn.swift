//
//  LandingMenuBtn.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/5/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class LandingMenuBtn: UIButton {

    var btnIcon = UIImageView()
    var btnTitle = UILabel()
    
    
    override func awakeFromNib() {
        
        btnIcon.frame = CGRect(x: 0, y: 25, width: 100, height: 50)
        btnIcon.contentMode = .scaleAspectFit
        btnIcon.tintColor = UIColor(red: 74/255, green: 174/255, blue: 106/255, alpha: 1)
        
        btnTitle.frame = CGRect(x: 0, y: btnIcon.frame.maxY + 5, width: 100, height: 21)
        btnTitle.textColor = UIColor.white
        btnTitle.font = UIFont(name: "GE SS Two", size: 15)
        btnTitle.textAlignment = .center
        
        addSubview(btnIcon)
        addSubview(btnTitle)
    }
    
    override func draw(_ rect: CGRect) {
        
        btnIcon.frame = CGRect(x: 0, y: 25, width: 100, height: 50)
        btnIcon.contentMode = .scaleAspectFit
        btnIcon.tintColor = UIColor(red: 74/255, green: 174/255, blue: 106/255, alpha: 1)
        
        btnTitle.frame = CGRect(x: 0, y: btnIcon.frame.maxY + 5, width: 100, height: 21)
        btnTitle.textColor = UIColor.white
        btnTitle.font = UIFont(name: "GE SS Two", size: 15)
        btnTitle.textAlignment = .center
        
        addSubview(btnIcon)
        addSubview(btnTitle)
        
    }

}
