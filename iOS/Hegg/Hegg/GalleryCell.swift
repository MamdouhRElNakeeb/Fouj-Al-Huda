//
//  GalleryCell.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/8/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import SDWebImage

class GalleryCell: UICollectionViewCell {
    
    let picIV = UIImageView()
    let screenWidth = UIScreen.main.bounds.width
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    
        picIV.frame = CGRect(x: 0, y: 0, width: screenWidth / 3, height: screenWidth / 3)
        picIV.contentMode = .scaleAspectFill
        picIV.layer.masksToBounds = true
        
        contentView.addSubview(picIV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
