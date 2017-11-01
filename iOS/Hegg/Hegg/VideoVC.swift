//
//  VideoVC.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/4/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import Alamofire
import YouTubePlayer

class VideoVC: UIViewController, UITableViewDelegate, UITableViewDataSource, SWRevealViewControllerDelegate {

    var videosTV: UITableView = UITableView()
    
    var videosArray = Array<Video>()
    let videosUrl = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=PLULt7R-fsx1GBS3c2bJ7Afy9p1XSiJCMJ&maxResults=30&key=AIzaSyAaKC-V6JT2M0iP6NUm3aXWkHBElCySfxQ"
    
    var spinner = UIActivityIndicatorView()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

    var videoPlayer = YouTubePlayerView()
    
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
        labelTitle.text = "فيديوهات الحملة"
        labelTitle.font = UIFont(name: "GE SS Two", size: 17)
        labelTitle.textColor = UIColor.secondryColor()
        self.navigationItem.titleView = labelTitle
        
        loadVideos()
        initVideosTV()
        //initSpinner()
        
        let whiteNB = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        whiteNB.backgroundColor = UIColor.primaryColor()
        self.view.addSubview(whiteNB)

    }
    
    func initVideosTV(){
        
        videosTV = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height), style: UITableViewStyle.plain)
        videosTV.register(VideoCell.self, forCellReuseIdentifier: "VideoCell")
        videosTV.dataSource = self
        videosTV.delegate = self
        videosTV.separatorStyle = .none
        
        self.view.addSubview(videosTV)
        
        videoPlayer = YouTubePlayerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        videoPlayer.isHidden = true
        self.view.addSubview(videoPlayer)
        videoPlayer.delegate = self
        
        
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
    
    func loadVideos(){
        
        //displaySpinner()
        let utils: Utils = Utils()
        
        if !utils.isConnectedToNetwork(){
            
            //dismissSpinner()
            let alert = UIAlertController(title: "تنبيه", message: "يوجد مشكلة فى الإتصال بالإنترنت", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "حاول مرة أخرى", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Alamofire.request(Urls.videos)
            .responseJSON{
                
                response in
                
                //self.dismissSpinner()
                //print(response)
                
                if let result = response.result.value {
                    
                    let videosJSONObject = result as! NSObject
                    
                    print(videosJSONObject)
                    
                    let videoItemsArr = videosJSONObject.value(forKey: "items") as! NSArray
                    
                    for videoItem in videoItemsArr {
                        
                        let videoSnippetObj = (videoItem as AnyObject).value(forKey: "snippet") as! NSObject
                        
                        let videoIdObj = videoSnippetObj.value(forKey: "resourceId") as! NSObject
                        let videoId = videoIdObj.value(forKey: "videoId") as! String
                        
                        let videoName = videoSnippetObj.value(forKey: "title") as! String
                        
                        let videoThumbObj = videoSnippetObj.value(forKey: "thumbnails") as! NSObject
                        let videoThumvMedObj = videoThumbObj.value(forKey: "medium") as! NSObject
                        
                        let thumbnailUrl = videoThumvMedObj.value(forKey: "url") as! String
                        
                        self.videosArray.append(Video.init(name: videoName, thumbnail: thumbnailUrl, url: videoId))
                    }
                    
                }
                
                self.videosTV.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        
        cell.videoLbl.text = videosArray[indexPath.row].name
        cell.thumbnailIV.sd_setImage(with: URL(string: videosArray[indexPath.row].thumbnail))
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let youtubeId = videosArray[indexPath.row].url
        var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
        
        videoPlayer.loadVideoID(youtubeId)
        videoPlayer.isHidden = false
        
        /*
        
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
            UIApplication.shared.openURL(youtubeUrl as URL)
        } else{
            youtubeUrl = NSURL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
            UIApplication.shared.openURL(youtubeUrl as URL)
        }
 */
    }
}

extension VideoVC: YouTubePlayerDelegate {

    func playerReady(_ videoPlayer: YouTubePlayerView) {
        videoPlayer.play()
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        
        if videoPlayer.playerState == .Ended {
           self.videoPlayer.isHidden = true
        }
    }
    
}


