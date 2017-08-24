//
//  MapListCell.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/12/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class MapListCell: UITableViewCell {

    let titleLbl = UILabel()
    let icon = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let viewWidth = Int(UIScreen.main.bounds.width)
        let cellHeight = 100
        
        icon.frame = CGRect(x: viewWidth - 70, y: 0, width: 60, height: cellHeight)
        icon.image = UIImage(named: "logo_icon")
        icon.contentMode = .scaleAspectFit
        
        titleLbl.frame = CGRect(x: 10, y: 0, width: viewWidth - 90, height: cellHeight)
        titleLbl.textAlignment = .right
        titleLbl.font = UIFont(name: "GE SS Two", size: 17)
        titleLbl.textColor = UIColor.black
        titleLbl.numberOfLines = 2
        
        contentView.addSubview(icon)
        contentView.addSubview(titleLbl)
        
    }
    
}
