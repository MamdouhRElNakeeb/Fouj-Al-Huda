//
//  NewsCell.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/7/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {

    let imageIV = UIImageView()
    let titleLbl = UILabel()
    let descLbl = UILabel()
    let timeLbl = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let roundedView = UIView(frame: CGRect(x: 15, y: 10, width: UIScreen.main.bounds.width - 30 , height: 120))
        roundedView.backgroundColor = UIColor.white
        roundedView.layer.cornerRadius = 5
        
        imageIV.frame = CGRect(x: roundedView.frame.width - 110, y: 10, width: 100, height: 100)
        imageIV.contentMode = .scaleAspectFill
        imageIV.layer.masksToBounds = true
        
        titleLbl.frame = CGRect(x: 10, y: 10, width: roundedView.frame.width - 130, height: 20)
        titleLbl.textAlignment = .right
        titleLbl.font = UIFont(name: "GE SS Two", size: 16)
        titleLbl.textColor = UIColor.black
        titleLbl.numberOfLines = 1
        
        descLbl.frame = CGRect(x: 10, y: titleLbl.frame.maxY, width: roundedView.frame.width - 130, height: 60)
        descLbl.textAlignment = .right
        descLbl.font = UIFont(name: "GE SS Two", size: 13)
        descLbl.textColor = UIColor.lightGray
        descLbl.numberOfLines = 3

        timeLbl.frame = CGRect(x: 10, y: roundedView.frame.height - 30, width: roundedView.frame.width - 130, height: 20)
        timeLbl.textAlignment = .left
        timeLbl.font = UIFont(name: "GE SS Two", size: 12)
        timeLbl.textColor = UIColor.lightGray
        timeLbl.numberOfLines = 1
        
        roundedView.addSubview(imageIV)
        roundedView.addSubview(titleLbl)
        roundedView.addSubview(descLbl)
        roundedView.addSubview(timeLbl)
        
        roundedView.dropShadow2()
        
        self.contentView.addSubview(roundedView)
        
        //self.contentView.dropShadow2()
        
    }
    

}
