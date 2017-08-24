//
//  ViewController.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 7/28/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class LandingVC: UIViewController, UIGestureRecognizerDelegate {

    var aboutVBtn = UIButton()
    var newsVBtn = UIButton()
    var timelineVBtn = UIButton()
    var mapVBtn = UIButton()
    var mapVBtn2 = UIButton()
    var fatawyVBtn = UIButton()
    var galleryVBtn = UIButton()
    var videosVBtn = UIButton()
    
    var userIDTF = String()
    
    let viewDim: CGFloat = 120
    let viewMargin: CGFloat = 24
   
    let userUrl = "http://hegg.nakeeb.me/API/hoda/insertUser.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        
        Messaging.messaging().subscribe(toTopic: "news")
        print("Subscribed to news topic")
        
        let bgImg = UIImageView(image: UIImage(named: "landing_bg"))
        bgImg.contentMode = .scaleAspectFill
        bgImg.frame = self.view.frame
        
        self.view.addSubview(bgImg)
        
        let image = UIImage(named:"sideMenuIcon")?.withRenderingMode(.alwaysTemplate)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(SSASideMenu.presentRightMenuViewController))
        
        initViews()
        
        if  !UserDefaults.standard.bool(forKey: "logged"){
            joinUser()
        }
        
        let labelTitle = UILabel()
        labelTitle.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        labelTitle.text = "مرحباً بك"
        labelTitle.font = UIFont(name: "GE SS Two", size: 17)
        labelTitle.textColor = UIColor.secondryColor()
        self.navigationItem.titleView = labelTitle
        
        
        let whiteNB = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        whiteNB.backgroundColor = UIColor.primaryColor()
        self.view.addSubview(whiteNB)
        
        
        
    }
    
    func joinUser(){
        
        let alert = UIAlertController(title: "مرحباً بك", message: "أدخل الرقم التعريفى الخاص بك", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "User ID"
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "إدخال", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction) -> Void in
            
            self.userIDTF = alert.textFields![0].text!
            print(self.userIDTF)
            let userDefaults = UserDefaults.standard
            userDefaults.set(self.userIDTF, forKey: "userID")
            userDefaults.set(true, forKey: "logged")
            userDefaults.synchronize()
            
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func initViews(){
        
        let menuV = UIView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64))
        
        mapVBtn.frame = CGRect(x: (menuV.frame.width / 2) + viewMargin, y: (menuV.frame.height / 2) - (viewMargin * 3 / 2) - (viewDim * 2), width: viewDim, height: viewDim)
        
        let mapLocationsIcon = UIImageView(image: UIImage(named: "markerIcon")?.withRenderingMode(.alwaysTemplate))
        mapLocationsIcon.tintColor = UIColor.white
        mapLocationsIcon.frame = CGRect(x: 0, y: 15, width: mapVBtn.frame.width, height: 50)
        mapLocationsIcon.contentMode = .scaleAspectFit
        
        let mapLocationsLbl = UILabel(frame: CGRect(x: 0, y: mapLocationsIcon.frame.maxY + 10, width: mapVBtn.frame.width, height: 20))
        mapLocationsLbl.font = UIFont(name: "GE SS Two", size: 12)
        mapLocationsLbl.textColor = UIColor.secondryColor()
        mapLocationsLbl.textAlignment = .center
        mapLocationsLbl.text = "مواقعنا بالمشاعر"
        mapLocationsLbl.dropShadow2()
        
        mapVBtn.addSubview(mapLocationsIcon)
        mapVBtn.addSubview(mapLocationsLbl)
        
        mapVBtn2.frame = CGRect(x: (menuV.frame.width / 2) - viewDim - viewMargin, y: mapVBtn.frame.minY, width: viewDim, height: viewDim)
        
        let mapLocationsIcon2 = UIImageView(image: UIImage(named: "mapIcon")?.withRenderingMode(.alwaysTemplate))
        mapLocationsIcon2.tintColor = UIColor.white
        mapLocationsIcon2.frame = CGRect(x: 0, y: 15, width: mapVBtn2.frame.width, height: 50)
        mapLocationsIcon2.contentMode = .scaleAspectFit
        
        let mapLocationsLbl2 = UILabel(frame: CGRect(x: 0, y: mapLocationsIcon2.frame.maxY + 10, width: mapVBtn2.frame.width, height: 20))
        mapLocationsLbl2.font = UIFont(name: "GE SS Two", size: 12)
        mapLocationsLbl2.textColor = UIColor.secondryColor()
        mapLocationsLbl2.textAlignment = .center
        mapLocationsLbl2.text = "أماكن التجمع"
        mapLocationsLbl2.dropShadow2()
        
        mapVBtn2.addSubview(mapLocationsIcon2)
        mapVBtn2.addSubview(mapLocationsLbl2)
        
        
        timelineVBtn.frame = CGRect(x: (menuV.frame.width / 2) + viewMargin, y: (menuV.frame.height / 2) - (viewMargin / 2) - viewDim, width: viewDim, height: viewDim)
        
        let timelineIcon = UIImageView(image: UIImage(named: "timelineIcon")?.withRenderingMode(.alwaysTemplate))
        timelineIcon.tintColor = UIColor.white
        timelineIcon.frame = CGRect(x: 0, y: 15, width: timelineVBtn.frame.width, height: 50)
        timelineIcon.contentMode = .scaleAspectFit
        
        let timelineLbl = UILabel(frame: CGRect(x: 0, y: timelineIcon.frame.maxY + 10, width: timelineVBtn.frame.width, height: 20))
        timelineLbl.font = UIFont(name: "GE SS Two", size: 17)
        timelineLbl.textColor = UIColor.secondryColor()
        timelineLbl.textAlignment = .center
        timelineLbl.text = "الجدول"
        timelineLbl.dropShadow2()
        
        timelineVBtn.addSubview(timelineIcon)
        timelineVBtn.addSubview(timelineLbl)
        
        fatawyVBtn.frame = CGRect(x: (menuV.frame.width / 2) - viewDim -  viewMargin, y: timelineVBtn.frame.minY, width: viewDim, height: viewDim)
        
        let fatawyIcon = UIImageView(image: UIImage(named: "fatwasIcon")?.withRenderingMode(.alwaysTemplate))
        fatawyIcon.tintColor = UIColor.white
        fatawyIcon.frame = CGRect(x: 0, y: 15, width: fatawyVBtn.frame.width, height: 50)
        fatawyIcon.contentMode = .scaleAspectFit
        
        let fatawyLbl = UILabel(frame: CGRect(x: 0, y: fatawyIcon.frame.maxY + 10, width: fatawyVBtn.frame.width, height: 20))
        fatawyLbl.font = UIFont(name: "GE SS Two", size: 17)
        fatawyLbl.textColor = UIColor.secondryColor()
        fatawyLbl.textAlignment = .center
        fatawyLbl.text = "الفتاوى"
        fatawyLbl.dropShadow2()
        
        fatawyVBtn.addSubview(fatawyIcon)
        fatawyVBtn.addSubview(fatawyLbl)
        

        
        galleryVBtn.frame = CGRect(x: (menuV.frame.width / 2) - viewDim - viewMargin, y: (menuV.frame.height / 2) + (viewMargin / 2), width: viewDim, height: viewDim)
        
        let galleryIcon = UIImageView(image: UIImage(named: "galleryIcon")?.withRenderingMode(.alwaysTemplate))
        galleryIcon.tintColor = UIColor.white
        galleryIcon.frame = CGRect(x: 0, y: 15, width: galleryVBtn.frame.width, height: 50)
        galleryIcon.contentMode = .scaleAspectFit
        
        let galleryLbl = UILabel(frame: CGRect(x: 0, y: galleryIcon.frame.maxY + 10, width: galleryVBtn.frame.width, height: 20))
        galleryLbl.font = UIFont(name: "GE SS Two", size: 17)
        galleryLbl.textColor = UIColor.secondryColor()
        galleryLbl.textAlignment = .center
        galleryLbl.text = "صور"
        galleryLbl.dropShadow2()
        
        galleryVBtn.addSubview(galleryIcon)
        galleryVBtn.addSubview(galleryLbl)
        
        videosVBtn.frame = CGRect(x: (menuV.frame.width / 2) + viewMargin, y: galleryVBtn.frame.minY, width: viewDim, height: viewDim)

        let videosIcon = UIImageView(image: UIImage(named: "videosIcon")?.withRenderingMode(.alwaysTemplate))
        videosIcon.tintColor = UIColor.white
        videosIcon.frame = CGRect(x: 0, y: 15, width: videosVBtn.frame.width, height: 50)
        videosIcon.contentMode = .scaleAspectFit
        
        let videosLbl = UILabel(frame: CGRect(x: 0, y: videosIcon.frame.maxY + 10, width: videosVBtn.frame.width, height: 20))
        videosLbl.font = UIFont(name: "GE SS Two", size: 17)
        videosLbl.textColor = UIColor.secondryColor()
        videosLbl.textAlignment = .center
        videosLbl.text = "فيديوهات"
        videosLbl.dropShadow2()
        
        videosVBtn.addSubview(videosIcon)
        videosVBtn.addSubview(videosLbl)
        
        aboutVBtn.frame = CGRect(x: (menuV.frame.width / 2) - viewDim - viewMargin, y: (menuV.frame.height / 2) + (viewMargin * 3 / 2) + viewDim, width: viewDim, height: viewDim)
        let aboutIcon = UIImageView(image: UIImage(named: "aboutIcon")?.withRenderingMode(.alwaysTemplate))
        aboutIcon.tintColor = UIColor.white
        aboutIcon.frame = CGRect(x: 0, y: 15, width: aboutVBtn.frame.width, height: 50)
        aboutIcon.contentMode = .scaleAspectFit
        
        let aboutLbl = UILabel(frame: CGRect(x: 0, y: aboutIcon.frame.maxY + 10, width: aboutVBtn.frame.width, height: 20))
        aboutLbl.font = UIFont(name: "GE SS Two", size: 16)
        aboutLbl.textColor = UIColor.secondryColor()
        aboutLbl.textAlignment = .center
        aboutLbl.text = "عن الشركة"
        aboutLbl.dropShadow2()
        
        aboutVBtn.addSubview(aboutIcon)
        aboutVBtn.addSubview(aboutLbl)
        
        newsVBtn.frame = CGRect(x: (menuV.frame.width / 2) + viewMargin, y: aboutVBtn.frame.minY, width: viewDim, height: viewDim)
        
        let newsIcon = UIImageView(image: UIImage(named: "newsIcon")?.withRenderingMode(.alwaysTemplate))
        newsIcon.tintColor = UIColor.white
        newsIcon.frame = CGRect(x: 0, y: 15, width: newsVBtn.frame.width, height: 50)
        newsIcon.contentMode = .scaleAspectFit
        
        let newsLbl = UILabel(frame: CGRect(x: 0, y: newsIcon.frame.maxY + 10, width: newsVBtn.frame.width, height: 20))
        newsLbl.font = UIFont(name: "GE SS Two", size: 16)
        newsLbl.textColor = UIColor.secondryColor()
        newsLbl.textAlignment = .center
        newsLbl.text = "الأخبار"
        newsLbl.dropShadow2()
        
        newsVBtn.addSubview(newsIcon)
        newsVBtn.addSubview(newsLbl)
        
        let color = UIColor.secondryColor()
        aboutVBtn.addBorder(view: aboutVBtn, stroke: color, fill: UIColor.clear, radius: 0, width: 2)
        newsVBtn.addBorder(view: newsVBtn, stroke: color, fill: UIColor.clear, radius: 0, width: 2)
        timelineVBtn.addBorder(view: timelineVBtn, stroke: color, fill: UIColor.clear, radius: 0, width: 2)
        mapVBtn.addBorder(view: mapVBtn, stroke: color, fill: UIColor.clear, radius: 0, width: 2)
        mapVBtn2.addBorder(view: mapVBtn2, stroke: color, fill: UIColor.clear, radius: 0, width: 2)
        fatawyVBtn.addBorder(view: fatawyVBtn, stroke: color, fill: UIColor.clear, radius: 0, width: 2)
        galleryVBtn.addBorder(view: galleryVBtn, stroke: color, fill: UIColor.clear, radius: 0, width: 2)
        videosVBtn.addBorder(view: videosVBtn, stroke: color, fill: UIColor.clear, radius: 0, width: 2)
        
        
        let aboutBtnTap = UITapGestureRecognizer(target: self, action: #selector(openAbout))
        aboutBtnTap.delegate = self
        aboutVBtn.addGestureRecognizer(aboutBtnTap)
        
        
        let newsBtnTap = UITapGestureRecognizer(target: self, action: #selector(openNews))
        newsBtnTap.delegate = self
        newsVBtn.addGestureRecognizer(newsBtnTap)
        
        let timelineBtnTap = UITapGestureRecognizer(target: self, action: #selector(openTimeline))
        timelineBtnTap.delegate = self
        timelineVBtn.addGestureRecognizer(timelineBtnTap)
        
        let mapBtnTap = UITapGestureRecognizer(target: self, action: #selector(openMap))
        mapBtnTap.delegate = self
        mapVBtn.addGestureRecognizer(mapBtnTap)
        
        let mapBtnTap2 = UITapGestureRecognizer(target: self, action: #selector(openMap2))
        mapBtnTap2.delegate = self
        mapVBtn2.addGestureRecognizer(mapBtnTap2)
        
        let fatawyBtnTap = UITapGestureRecognizer(target: self, action: #selector(openFatawy))
        fatawyBtnTap.delegate = self
        fatawyVBtn.addGestureRecognizer(fatawyBtnTap)
        
        
        let galleryBtnTap = UITapGestureRecognizer(target: self, action: #selector(openGallery))
        galleryBtnTap.delegate = self
        galleryVBtn.addGestureRecognizer(galleryBtnTap)
        
        
        let videosBtnTap = UITapGestureRecognizer(target: self, action: #selector(openVideos))
        videosBtnTap.delegate = self
        videosVBtn.addGestureRecognizer(videosBtnTap)
        
        menuV.addSubview(aboutVBtn)
        menuV.addSubview(newsVBtn)
        menuV.addSubview(timelineVBtn)
        menuV.addSubview(mapVBtn)
        menuV.addSubview(mapVBtn2)
        menuV.addSubview(fatawyVBtn)
        menuV.addSubview(galleryVBtn)
        menuV.addSubview(videosVBtn)
        
        self.view.addSubview(menuV)
        
    }
    
    func openMap() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mapList") as! MapListVC
        newViewController.mapListType = true
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func openMap2() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mapList") as! MapListVC
        newViewController.mapListType = false
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func openFatawy() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "fatawy") as! FatawyAnswersVC
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func openAbout() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "about") as! AboutVC
        self.navigationController?.pushViewController(newViewController, animated: true)

    }
    
    func openVideos() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "videos") as! VideoVC
        self.navigationController?.pushViewController(newViewController, animated: true)
    }

    func openNews() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "news") as! NewsVC
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func openTimeline() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "timeline") as! TimelineVC
        self.navigationController?.pushViewController(newViewController, animated: true)
    }

    func openGallery() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "gallery") as! GalleryVC
        self.navigationController?.pushViewController(newViewController, animated: true)
    }

}



