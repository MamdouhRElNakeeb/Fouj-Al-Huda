//
//  VideoCell.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/4/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import SDWebImage

class VideoCell: UITableViewCell {

    let thumbnailIV = UIImageView()
    let videoLbl = UILabel()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let roundedView = UIView(frame: CGRect(x: 20, y: 10, width: UIScreen.main.bounds.width - 40 , height: 180))
        roundedView.layer.cornerRadius = 20
        
        thumbnailIV.frame = CGRect(x: 0, y: 0, width: roundedView.frame.width, height: roundedView.frame.height)
        thumbnailIV.layer.cornerRadius = 20
        thumbnailIV.contentMode = .scaleAspectFill
        
        let gradientV = UIImageView(image: UIImage(named: "gradientGreen"))
        gradientV.frame = CGRect(x: 0, y: 0, width: roundedView.frame.width, height: roundedView.frame.height)
        gradientV.layer.cornerRadius = 20
        gradientV.tintColor = UIColor.primaryColor()
        
        videoLbl.frame = CGRect(x: 20, y: 140, width: roundedView.frame.width - 40, height: 40)
        videoLbl.textAlignment = .right
        videoLbl.font = UIFont(name: "GE SS Two", size: 16)
        videoLbl.textColor = UIColor.white
        
        let playBtn = UIImageView(frame: CGRect(x: 0, y: (roundedView.frame.height / 2) - 35, width: roundedView.frame.width, height: 70))
        playBtn.contentMode = .scaleAspectFit
        playBtn.image = UIImage(named: "playBtn")
        playBtn.tintColor = UIColor.secondryColor()
        playBtn.dropShadow2()
        
        let maskPath = UIBezierPath(roundedRect: roundedView.bounds,byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer(layer: maskPath)
        maskLayer.frame = roundedView.bounds
        maskLayer.path = maskPath.cgPath
        roundedView.layer.mask = maskLayer
        
        
        roundedView.addSubview(thumbnailIV)
        roundedView.addSubview(gradientV)
        roundedView.addSubview(videoLbl)
        roundedView.addSubview(playBtn)
        
        //roundedView.dropShadow2()
        
        self.contentView.addSubview(roundedView)
        
        self.contentView.dropShadow2()
        
    }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
