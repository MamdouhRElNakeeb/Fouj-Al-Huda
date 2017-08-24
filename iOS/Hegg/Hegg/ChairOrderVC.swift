//
//  ChairOrderVC.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/9/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import Alamofire

class ChairOrderVC: UIViewController {
    
    var subjectTF = UITextField()
    var msgTF = UITextView()
    
    var userIDTF = String()
    
    var spinner = UIActivityIndicatorView()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
    let margin: CGFloat = 30
    
    let contactMsgUrl = "http://hegg.nakeeb.me/API/hoda/chairOrder.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        let image = UIImage(named:"sideMenuIcon")?.withRenderingMode(.alwaysTemplate)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(SSASideMenu.presentRightMenuViewController))
        
        initViews()
        
        let hideKeyboard = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        hideKeyboard.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(hideKeyboard)
        
    }
    
    func initViews(){
        
        let bgImg = UIImageView(image: UIImage(named: "landing_bg"))
        bgImg.contentMode = .scaleAspectFill
        bgImg.frame = self.view.frame
        
        self.view.addSubview(bgImg)
        
        let logoIV = UIImageView(image: UIImage(named: "logo_icon"))
        
        logoIV.frame = CGRect(x: self.view.frame.width - margin * 4, y: 110, width: 100, height: 100)
        logoIV.tintColor = UIColor.white
        
        let contactIconImg = UIImage(named:"chairIcon")?.withRenderingMode(.alwaysTemplate)
        let contactIconIV = UIImageView(image: contactIconImg)
        contactIconIV.tintColor = UIColor.white
        contactIconIV.frame = CGRect(x: margin, y: 60, width: 90, height: 90)
        
        let contactLbl = UILabel(frame: CGRect(x: margin, y: contactIconIV.frame.maxY + 10, width: 90, height: 15))
        contactLbl.text = "طلب كرسى"
        contactLbl.font = UIFont(name: "GE SS Two", size: 14)
        contactLbl.textAlignment = .center
        contactLbl.textColor = UIColor.white
        
        let greenTriangle = UIView.Triangle(height: 80, width: self.view.frame.width).getTriangle()
        greenTriangle.frame = CGRect(x: 0, y: 130, width: self.view.frame.width, height: 80)
        greenTriangle.backgroundColor = UIColor.secondryColor()
        
        let greyTriangle = UIView.Triangle(height: greenTriangle.frame.height - 20, width: self.view.frame.width).getTriangle()
        greyTriangle.frame = CGRect(x: 0, y: greenTriangle.frame.minY + 20, width: self.view.frame.width, height: greenTriangle.frame.height - 20)
        greyTriangle.backgroundColor = UIColor.lightGray
        
        let whiteTriangle = UIView.Triangle(height: greyTriangle.frame.height - 10, width: self.view.frame.width).getTriangle()
        whiteTriangle.frame = CGRect(x: 0, y: greyTriangle.frame.minY + 10, width: self.view.frame.width, height: greyTriangle.frame.height - 10)
        whiteTriangle.backgroundColor = UIColor.white
        
        let whiteV = UIView(frame: CGRect(x: 0, y: whiteTriangle.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - whiteTriangle.frame.maxY))
        whiteV.backgroundColor = UIColor.white
        
        let subjectV = UIView(frame: CGRect(x: margin * 3 / 2, y: (self.view.frame.height / 2) - 22, width: self.view.frame.width - margin * 3, height: 44))
        subjectV.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        
        subjectTF = UITextField(frame: CGRect(x: margin / 4, y: 0, width: subjectV.frame.width - margin / 2, height: 44))
        
        subjectTF.placeholder = "رقم الجوال"
        subjectTF.keyboardType = .phonePad
        subjectTF.textAlignment = .right
        subjectTF.font = UIFont(name: "GE SS Two", size: 14)
        subjectTF.textColor = UIColor.black
        subjectTF.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        
        subjectV.addSubview(subjectTF)
        
        let sendBtn = UIButton(frame: CGRect(x: margin * 3 / 2, y: subjectV.frame.maxY + 10, width: self.view.frame.width - margin * 3, height: 44))
        
        sendBtn.setTitle("طلب كرسى", for: .normal)
        sendBtn.titleLabel?.font = UIFont(name: "GE SS Two", size: 14)
        sendBtn.backgroundColor = UIColor.primaryColor()
        sendBtn.titleLabel?.textColor = UIColor.white
        
        sendBtn.addTarget(self, action: #selector(sendMsg), for: .touchUpInside)
        
        self.view.addSubview(greenTriangle)
        self.view.addSubview(greyTriangle)
        self.view.addSubview(whiteTriangle)
        self.view.addSubview(whiteV)
        self.view.addSubview(logoIV)
        self.view.addSubview(contactLbl)
        self.view.addSubview(contactIconIV)
        self.view.addSubview(subjectV)
        self.view.addSubview(sendBtn)
        
    }
    
    func initSpinner(){
        spinner.activityIndicatorViewStyle = .gray
        spinner.center = self.view.center
        
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
        spinner.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        
        let strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = "جارى الإرسال"
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
    
    func sendMsg(){
        
        if (subjectTF.text?.isEmpty)! {
            let alert = UIAlertController(title: "تنبيه", message: "برجاء ملئ جميع البيانات", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "حاول مرة أخرى", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        
        displaySpinner()
        
        let utils: Utils = Utils()
        
        if !utils.isConnectedToNetwork(){
            dismissSpinner()
            let alert = UIAlertController(title: "تنبيه", message: "يوجد مشكلة فى الإتصال بالإنترنت", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "حاول مرة أخرى", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        let parameters: Parameters=[
            "userID": subjectTF.text!
        ]
        
        print(parameters)
        
        
        Alamofire.request(contactMsgUrl, method: .post, parameters: parameters)
            .responseJSON{
                
                response in
                
                self.dismissSpinner()
                print(response)
                
                if let result = response.result.value{
                    
                    let msgObj = result as! NSObject
                    
                    let msg = msgObj.value(forKey: "msg") as! String
                    
                    if msg == "success"{
                        let alert = UIAlertController(title: "تم الإرسال", message: "تم إرسال الطلب بنجاح", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "حسناً", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
        }
    }
    
    func hideKeyboard(_ recognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
}
