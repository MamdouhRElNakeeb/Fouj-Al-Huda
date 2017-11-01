//
//  MapListVC.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/12/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import Alamofire

class MapListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, SWRevealViewControllerDelegate {

    var mapListType: Bool = true
    
    var mapListTV: UITableView = UITableView()
    var spinner = UIActivityIndicatorView()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    let dateFormat: DateFormat = DateFormat(format: "dd MMMM")
    
    var campLocations = Array<Camp>()
    var mapListUrl = ""
    
    let curTimeInMillis = Date().timeIntervalSince1970
    
    
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
//        
        self.navigationItem.leftBarButtonItem?.title = "رجوع"
 
        let labelTitle = UILabel()
        labelTitle.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        if mapListType {
            
            labelTitle.text = "مواقعنا بالمشاعر"
            mapListUrl = Urls.camp
        }
        else{
            
            labelTitle.text = "أماكن التجمع"
            mapListUrl = Urls.gather
        }
        
        labelTitle.font = UIFont(name: "GE SS Two", size: 17)
        labelTitle.textColor = UIColor.secondryColor()
        self.navigationItem.titleView = labelTitle
        
        let whiteV = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        whiteV.backgroundColor = UIColor.white
        self.view.addSubview(whiteV)
        
        loadMapList()
        initMapListTV()
        //initSpinner()
        
        let whiteNB = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        whiteNB.backgroundColor = UIColor.primaryColor()
        self.view.addSubview(whiteNB)
    }

    func initMapListTV(){
        
        mapListTV = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height), style: UITableViewStyle.plain)
        mapListTV.register(MapListCell.self, forCellReuseIdentifier: "mapListCell")
        mapListTV.dataSource = self
        mapListTV.delegate = self
        
        self.view.addSubview(mapListTV)
        
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
    
    func loadMapList(){
        
        //displaySpinner()
        
        let utils: Utils = Utils()
        
        if !utils.isConnectedToNetwork(){
            //dismissSpinner()
            let alert = UIAlertController(title: "تنبيه", message: "يوجد مشكلة فى الإتصال بالإنترنت", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "حاول مرة أخرى", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Alamofire.request(mapListUrl)
            .responseJSON{
                
                response in
                
                //self.dismissSpinner()
                
                print(response)
                
                if let result = response.result.value{
                    
                    let campLocArr = result as! NSArray
                    
                    for campLoc in campLocArr{
                        
                        self.campLocations.append(Camp.init(id: Int((campLoc as AnyObject).value(forKey: "id") as! String)!,
                                             name: (campLoc as AnyObject).value(forKey: "name") as! String,
                                             latitude: Double((campLoc as AnyObject).value(forKey: "latitude") as! String)!,
                                             longitude: Double((campLoc as AnyObject).value(forKey: "longitude") as! String)!,
                                             description: (campLoc as AnyObject).value(forKey: "description") as! String))
                        
                    }
                    
                }
                
                self.mapListTV.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return campLocations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mapListCell", for: indexPath) as! MapListCell

        cell.titleLbl.text = campLocations[indexPath.row].name
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "map") as! MapLocations
        newViewController.camp = campLocations[indexPath.row]
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
}
