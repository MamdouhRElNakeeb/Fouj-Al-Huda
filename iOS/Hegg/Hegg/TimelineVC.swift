//
//  TimelineVC.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/7/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import Alamofire

class TimelineVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var timelineTV: UITableView = UITableView()
    var spinner = UIActivityIndicatorView()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

    let dateFormat: DateFormat = DateFormat(format: "dd MMMM")
    
    var timelineArray = Array<TimelineItem>()
    let timelineUrl = "http://hegg.nakeeb.me/API/hoda/getTimeline.php"
    
    let curTimeInMillis = Date().timeIntervalSince1970
    
    
    let greenColor = UIColor.primaryColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let image = UIImage(named:"sideMenuIcon")?.withRenderingMode(.alwaysTemplate)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(SSASideMenu.presentRightMenuViewController))
        
        self.navigationItem.leftBarButtonItem?.title = "رجوع"
        
        let labelTitle = UILabel()
        labelTitle.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        labelTitle.text = "الجدول الزمنى الحملة"
        labelTitle.font = UIFont(name: "GE SS Two", size: 17)
        labelTitle.textColor = UIColor.secondryColor()
        self.navigationItem.titleView = labelTitle
        
        let whiteV = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        whiteV.backgroundColor = UIColor.white
        self.view.addSubview(whiteV)
        
        loadtimeline()
        inittimelineTV()
        initSpinner()
        
        let whiteNB = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        whiteNB.backgroundColor = UIColor.primaryColor()
        self.view.addSubview(whiteNB)
        
        
    }
    
    func inittimelineTV(){
        
        timelineTV = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height), style: UITableViewStyle.plain)
        timelineTV.register(TimelineCell.self, forCellReuseIdentifier: "TimelineCell")
        timelineTV.dataSource = self
        timelineTV.delegate = self
        timelineTV.separatorStyle = .none
        timelineTV.backgroundColor = UIColor.clear
        
        let greenLine = UIView()
        greenLine.frame = CGRect(x: self.view.frame.width - 38, y: 0, width: 6, height: self.view.frame.height)
        greenLine.backgroundColor = UIColor.primaryColor()
        self.view.addSubview(greenLine)
        
        self.view.addSubview(timelineTV)
        
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
    
    func loadtimeline(){
        
        displaySpinner()
        
        let utils: Utils = Utils()
        
        if !utils.isConnectedToNetwork(){
            dismissSpinner()
            let alert = UIAlertController(title: "تنبيه", message: "يوجد مشكلة فى الإتصال بالإنترنت", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "حاول مرة أخرى", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Alamofire.request(timelineUrl)
            .responseJSON{
                
                response in
                
                self.dismissSpinner()
                
                print(response)
                
                if let result = response.result.value {
                    
                    let timelineJSONArr = result as! NSArray
                    
                    for timelineJSONObj in timelineJSONArr{
                        
                        self.timelineArray.append(TimelineItem.init(id: Int((timelineJSONObj as AnyObject).value(forKey: "id") as! String)!,
                                                            name: (timelineJSONObj as AnyObject).value(forKey: "name") as! String,
                                                            description: (timelineJSONObj as AnyObject).value(forKey: "description") as! String,
                                                            timeInMillis: Int((timelineJSONObj as AnyObject).value(forKey: "timeInMillis") as! String)! / 1000))
                        
                    }
                    
                }
                
                self.timelineTV.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineCell", for: indexPath) as! TimelineCell
        
        let curDayNo = self.dateFormat.getDateStr(dateMilli: Int(self.curTimeInMillis)).characters.split{$0 == ","}.map(String.init)[0]
        let timelineDayNo = self.dateFormat.getDateStr(dateMilli: timelineArray[indexPath.row].timeInMillis).characters.split{$0 == ","}.map(String.init)[0]
        
        if curDayNo == timelineDayNo {
            let circle = UIView.Circle(radius: 15, fill: greenColor, stroke: UIColor.clear).getCircle()
            let circle2 = UIView.Circle(radius: 15, fill: UIColor.white, stroke: greenColor).getCircle()
            
            circle.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            cell.checkPointV.addSubview(circle2)
            cell.checkPointV.addSubview(circle)
            print("pending")
        }
        else if (Int(self.curTimeInMillis)) > timelineArray[indexPath.row].timeInMillis{
            let circle = UIView.Circle(radius: 15, fill: greenColor, stroke: UIColor.clear).getCircle()
            
            cell.checkPointV.addSubview(circle)
            print("done")
        }
        else if (Int(self.curTimeInMillis)) < timelineArray[indexPath.row].timeInMillis{
            let circle = UIView.Circle(radius: 15, fill: UIColor.white, stroke: greenColor).getCircle()
            
            cell.checkPointV.addSubview(circle)
            print("upcoming")
        }
        
        cell.nameLbl.text = timelineArray[indexPath.row].name
        
        cell.descLbl.text = timelineArray[indexPath.row].description
        cell.timeLbl.text = self.dateFormat.getDateStr(dateMilli: timelineArray[indexPath.row].timeInMillis)
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

