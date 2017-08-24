//
//  GuideDetailsVC.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/19/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class GuideDetailsVC: UIViewController, UIWebViewDelegate {

    
    let pdfView: UIWebView = UIWebView()
    var guideItem = GuideItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let image = UIImage(named:"sideMenuIcon")?.withRenderingMode(.alwaysTemplate)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(SSASideMenu.presentRightMenuViewController))
        
        self.navigationItem.leftBarButtonItem?.title = "رجوع"
        
        let labelTitle = UILabel()
        labelTitle.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        labelTitle.text = guideItem.name
        labelTitle.font = UIFont(name: "GE SS Two", size: 17)
        labelTitle.textColor = UIColor.secondryColor()
        self.navigationItem.titleView = labelTitle
        
        
        let whiteNB = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        whiteNB.backgroundColor = UIColor.primaryColor()
        self.view.addSubview(whiteNB)
        
    
        initPdfView()
    }

    func initPdfView (){
        
        pdfView.frame = CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64)
        
        self.view.addSubview(pdfView)
        
        pdfView.delegate = self
        if let url = URL(string: guideItem.pdfURL) {
            let request = URLRequest(url: url)
            pdfView.loadRequest(request)
        }
    }
    
}
