//
//  FatwaCell.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/11/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class FatwaCell: UITableViewCell {

    
    let titleLbl = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let roundedView = UIView(frame: CGRect(x: 15, y: 10, width: UIScreen.main.bounds.width - 30 , height: 120))
        roundedView.backgroundColor = UIColor.white
        roundedView.layer.cornerRadius = 5
        
        
        titleLbl.frame = CGRect(x: 10, y: 10, width: roundedView.frame.width - 20, height: roundedView.frame.height - 20)
        titleLbl.textAlignment = .right
        titleLbl.font = UIFont(name: "GE SS Two", size: 14)
        titleLbl.textColor = UIColor.black
        titleLbl.numberOfLines = 4
        
        roundedView.addSubview(titleLbl)
        
        roundedView.dropShadow2()
        
        self.contentView.addSubview(roundedView)
                
    }
    
}
