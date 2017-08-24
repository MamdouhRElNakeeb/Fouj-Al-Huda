//
//  FatawyAnswersVC.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/11/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import Alamofire

class FatawyAnswersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var newsTV: UITableView = UITableView()
    
    var fatawyArray = Array<Fatwa>()
    let newsUrl = "http://hegg.nakeeb.me/API/hoda/getFatawy.php"
    
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
        labelTitle.text = "إجابات الفتاوى"
        labelTitle.font = UIFont(name: "GE SS Two", size: 17)
        labelTitle.textColor = UIColor.secondryColor()
        self.navigationItem.titleView = labelTitle
        
        loadnews()
        initnewsTV()
        initSpinner()
        
        let whiteNB = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        whiteNB.backgroundColor = UIColor.primaryColor()
        self.view.addSubview(whiteNB)
        
    }
    
    func initnewsTV(){
        
        newsTV = UITableView(frame: CGRect(x: 0, y: self.view.frame.minY + 64, width: self.view.frame.width, height: self.view.frame.height), style: UITableViewStyle.plain)
        newsTV.register(FatwaCell.self, forCellReuseIdentifier: "FatwaCell")
        newsTV.dataSource = self
        newsTV.delegate = self
        newsTV.separatorStyle = .none
        
        self.view.addSubview(newsTV)
        
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
    
    func loadnews(){
        
        displaySpinner()
        let utils: Utils = Utils()
        
        if !utils.isConnectedToNetwork(){
            dismissSpinner()
            let alert = UIAlertController(title: "تنبيه", message: "يوجد مشكلة فى الإتصال بالإنترنت", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "حاول مرة أخرى", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Alamofire.request(newsUrl)
            .responseJSON{
                
                response in
                
                self.dismissSpinner()
                //print(response)
                
                if let result = response.result.value {
                    
                    let fatawyJSONObj = result as! NSObject
                    
                    print(fatawyJSONObj)
                    
                    let fatawyJSONArr = result as! NSArray
                    
                    for fatwaObj in fatawyJSONArr{
                        
                        self.fatawyArray.append(Fatwa.init(question: (fatwaObj as AnyObject).value(forKey: "question") as! String, answer: (fatwaObj as AnyObject).value(forKey: "answer") as! String))
                        
                    }
                    
                }
                
                self.newsTV.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fatawyArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FatwaCell", for: indexPath) as! FatwaCell
        
        cell.titleLbl.text = fatawyArray[indexPath.row].question
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "fatwaDetails") as! FatwaDetails
        newViewController.fatwa = fatawyArray[indexPath.row]
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
}

