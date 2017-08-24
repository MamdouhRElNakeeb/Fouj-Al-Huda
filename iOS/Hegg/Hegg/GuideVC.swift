//
//  GuideVC.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/19/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import Alamofire

class GuideVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var guideTV: UITableView = UITableView()
    
    
    var guideArray = Array<GuideItem>()
    let guideUrl = "http://hegg.nakeeb.me/API/hoda/getGuide.php"
    
    var spinner = UIActivityIndicatorView()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let image = UIImage(named:"sideMenuIcon")?.withRenderingMode(.alwaysTemplate)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(SSASideMenu.presentRightMenuViewController))
        
        self.navigationItem.leftBarButtonItem?.title = "رجوع"
        
        let labelTitle = UILabel()
        labelTitle.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        labelTitle.text = "دليل الحاج"
        labelTitle.font = UIFont(name: "GE SS Two", size: 17)
        labelTitle.textColor = UIColor.secondryColor()
        self.navigationItem.titleView = labelTitle
        
        initSpinner()
        initguideTV()
        loadguide()
        
        let whiteNB = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        whiteNB.backgroundColor = UIColor.primaryColor()
        self.view.addSubview(whiteNB)
        
    }
    
    func initguideTV(){
        
        guideTV = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height), style: UITableViewStyle.plain)
        guideTV.register(MapListCell.self, forCellReuseIdentifier: "GuideCell")
        guideTV.dataSource = self
        guideTV.delegate = self
        guideTV.separatorStyle = .none
        
        self.view.addSubview(guideTV)
        
    }
    
    func initSpinner(){
        spinner.activityIndicatorViewStyle = .gray
        spinner.center = self.view.center
        
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
        spinner.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        
        let strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = "جارى التحميل"
        strLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        effectView.addSubview(spinner)
        effectView.addSubview(strLabel)
    }
    
    func dismissSpinner(){
        spinner.stopAnimating()
        effectView.removeFromSuperview()
    }
    
    func displaySpinner(){
        spinner.startAnimating()
        self.view.addSubview(effectView)
    }
    
    func loadguide(){
        
        displaySpinner()
        let utils: Utils = Utils()
        
        if !utils.isConnectedToNetwork(){
            dismissSpinner()
            let alert = UIAlertController(title: "تنبيه", message: "يوجد مشكلة فى الإتصال بالإنترنت", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "حاول مرة أخرى", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Alamofire.request(guideUrl)
            .responseJSON{
                
                response in
                
                self.dismissSpinner()
                print(response)
                
                if let result = response.result.value {
                    
                    
                    let guideJSONArr = result as! NSArray
                    
                    for guideJSONObj in guideJSONArr{
                        
                        self.guideArray.append(GuideItem.init(id: Int((guideJSONObj as AnyObject).value(forKey: "id") as! String)!,
                                                            name: (guideJSONObj as AnyObject).value(forKey: "name") as! String,
                                                            imageURL: (guideJSONObj as AnyObject).value(forKey: "image") as! String,
                                                            pdfURL: (guideJSONObj as AnyObject).value(forKey: "pdf") as! String))
                        
                    }
                    
                }
                
                self.guideTV.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guideArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuideCell", for: indexPath) as! MapListCell
        
        cell.titleLbl.text = guideArray[indexPath.row].name
        cell.icon.sd_setImage(with: URL(string: guideArray[indexPath.row].imageURL))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "guideDetails") as! GuideDetailsVC
        newViewController.guideItem = guideArray[indexPath.row]
 
        /*
        let remotePDFDocumentURL = URL(string: guideArray[indexPath.row].pdfURL)!
        print(remotePDFDocumentURL)
        let document = PDFDocument(url: remotePDFDocumentURL)!
        let readerController = PDFViewController.createNew(with: document, title: guideArray[indexPath.row].name)
        readerController.scrollDirection = .vertical
        readerController.backgroundColor = UIColor.white
        */
        
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
}

