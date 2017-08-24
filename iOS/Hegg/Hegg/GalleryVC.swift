//
//  GalleryVC.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/8/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import Alamofire
import CollieGallery

class GalleryVC: UIViewController {

    var galleryCV: UICollectionView!
    var spinner = UIActivityIndicatorView()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

    var pictures = [CollieGalleryPicture]()
    var gallery = CollieGallery()
    
    let galleryUrl = "http://hegg.nakeeb.me/API/hoda/"
    var galleryArray = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let image = UIImage(named:"sideMenuIcon")?.withRenderingMode(.alwaysTemplate)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(SSASideMenu.presentRightMenuViewController))
        
        self.navigationItem.leftBarButtonItem?.title = "رجوع"
        
        let labelTitle = UILabel()
        labelTitle.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        labelTitle.text = "صور الحملة"
        labelTitle.font = UIFont(name: "GE SS Two", size: 17)
        labelTitle.textColor = UIColor.secondryColor()
        self.navigationItem.titleView = labelTitle
        
       
        initGalleryCV()
        initSpinner()
        loadGallery()
        
        let whiteNB = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        whiteNB.backgroundColor = UIColor.primaryColor()
        self.view.addSubview(whiteNB)

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

    
    func initGalleryCV(){
        
        let itemSize = self.view.frame.width / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSize(width: itemSize,height: itemSize)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        galleryCV = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: flowLayout)
        galleryCV.setCollectionViewLayout(flowLayout, animated: true)
        galleryCV.register(GalleryCell.self, forCellWithReuseIdentifier: "GalleryCell")
        galleryCV.dataSource = self
        galleryCV.delegate = self
        galleryCV.backgroundColor = UIColor.white
        galleryCV.allowsSelection = true
        
        self.view.addSubview(galleryCV)
        
    }
    
    func loadGallery(){
     
        displaySpinner()
        
        let utils: Utils = Utils()
        
        if !utils.isConnectedToNetwork(){
            dismissSpinner()
            let alert = UIAlertController(title: "تنبيه", message: "يوجد مشكلة فى الإتصال بالإنترنت", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "حاول مرة أخرى", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Alamofire.request(galleryUrl + "gallery.php").responseJSON{
            
            response in
            
            self.dismissSpinner()
            print(response)
            
            if let result = response.result.value {
                
                let galleryJSONArr = result as! NSArray
                
                for galleryJSONObj in galleryJSONArr{
                    
                    self.galleryArray.append(galleryJSONObj as! String)
                    self.pictures.append(CollieGalleryPicture(url: self.galleryUrl + "Gallery/" + (galleryJSONObj as! String)))
                }
                
                self.galleryCV.reloadData()
                self.gallery = CollieGallery(pictures: self.pictures)
                
            }
            
        }
    }
    
    
}

extension GalleryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCell
        
        cell.picIV.sd_setImage(with: URL(string: galleryUrl + "Gallery/" + galleryArray[indexPath.row]))
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        self.gallery.presentInViewController(self)
        self.gallery.scrollToIndex(indexPath.row)
        print(indexPath.row)
    }
}

