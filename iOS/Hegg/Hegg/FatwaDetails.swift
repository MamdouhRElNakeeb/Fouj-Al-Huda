//
//  FatwaDetails.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/11/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class FatwaDetails: UIViewController, SWRevealViewControllerDelegate {

    var fatwa: Fatwa = Fatwa()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if revealViewController() != nil{
            
            self.revealViewController().delegate = self
            let image = UIImage(named:"sideMenuIcon")?.withRenderingMode(.alwaysTemplate)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target:  revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            
        }
        
//        let image = UIImage(named:"sideMenuIcon")?.withRenderingMode(.alwaysTemplate)
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(SSASideMenu.presentRightMenuViewController))
        
        self.navigationItem.leftBarButtonItem?.title = "رجوع"
        
        let labelTitle = UILabel()
        labelTitle.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        labelTitle.text = "إجابات الفتاوى"
        labelTitle.font = UIFont(name: "GE SS Two", size: 17)
        labelTitle.textColor = UIColor.secondryColor()
        self.navigationItem.titleView = labelTitle
        
        
        let whiteNB = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        whiteNB.backgroundColor = UIColor.primaryColor()
        self.view.addSubview(whiteNB)
        
        
        loadFatwa()
        
    }

    func loadFatwa(){
        
        let roundedView = UIView(frame: CGRect(x: 15, y: 10, width: UIScreen.main.bounds.width - 30 , height: 120))
        roundedView.backgroundColor = UIColor.white
        roundedView.layer.cornerRadius = 5
        
        let questionLbl = UILabel()
        questionLbl.frame = CGRect(x: 10, y: 70, width: self.view.frame.width - 20, height: 80)
        questionLbl.textAlignment = .right
        questionLbl.font = UIFont(name: "GE SS Two", size: 15)
        questionLbl.textColor = UIColor.black
        questionLbl.numberOfLines = 6
        
        questionLbl.text = fatwa.question
        
        let answerLbl = UILabel()
        answerLbl.frame = CGRect(x: 10, y: questionLbl.frame.maxY + 20, width: self.view.frame.width - 20, height: 200)
        answerLbl.textAlignment = .right
        answerLbl.font = UIFont(name: "GE SS Two", size: 13)
        answerLbl.textColor = UIColor.gray
        answerLbl.numberOfLines = 16
        
        answerLbl.text = fatwa.answer
        
        let line2 = UIView(frame: CGRect(x: 10 , y: questionLbl.frame.maxY + 10, width: self.view.frame.width - 20, height: 1))
        line2.backgroundColor = UIColor.lightGray
        line2.alpha = 0.3
        
        self.view.addSubview(line2)
        self.view.addSubview(questionLbl)
        self.view.addSubview(answerLbl)
        
    }

}
