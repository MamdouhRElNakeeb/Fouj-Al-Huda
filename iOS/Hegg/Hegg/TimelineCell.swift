//
//  TimelineCell.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/7/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell {

    var checkPointV = UIView()
    let nameLbl = UILabel()
    let descLbl = UILabel()
    let timeLbl = UILabel()
    let screenWidth = UIScreen.main.bounds.width
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        checkPointV.frame = CGRect(x: screenWidth - 50, y: 10, width: 30, height: 30)
        checkPointV.layer.masksToBounds = true
        checkPointV.layer.cornerRadius = 15
        
        nameLbl.frame = CGRect(x: 70, y: 10, width: screenWidth - 130, height: 20)
        nameLbl.textAlignment = .right
        nameLbl.font = UIFont(name: "GE SS Two", size: 16)
        nameLbl.textColor = UIColor.black
        nameLbl.numberOfLines = 1
        
        descLbl.frame = CGRect(x: 20, y: nameLbl.frame.maxY, width: screenWidth - 80, height: 60)
        descLbl.textAlignment = .right
        descLbl.font = UIFont(name: "GE SS Two", size: 13)
        descLbl.textColor = UIColor.lightGray
        descLbl.numberOfLines = 4
        
        timeLbl.frame = CGRect(x: 20, y: 10, width: 90, height: 20)
        timeLbl.textAlignment = .left
        timeLbl.font = UIFont(name: "GE SS Two", size: 12)
        timeLbl.textColor = UIColor.lightGray
        timeLbl.numberOfLines = 1
        
        self.contentView.addSubview(checkPointV)
        self.contentView.addSubview(nameLbl)
        self.contentView.addSubview(descLbl)
        self.contentView.addSubview(timeLbl)
        
        
    }
    
}
