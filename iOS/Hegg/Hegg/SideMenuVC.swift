//
//  SideMenuTVC.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 7/28/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let titles: [String] = [
        "الرئيسية",
        "مواقعنا بالمشاعر",
       "أماكن التجمع",
        "الجدول الزمنى",
        "فيديوهات",
        "صور",
        "الأخبار",
     "دليل الحاج",
        "طلب كرسى",
        "طلب فتوى",
        "الفتاوى",
        "عن الشركة",
  "دردشة",
        "إتصل بنا"]
    
    let images: [String] = ["homeIcon", "markerIcon", "mapIcon", "timelineIcon", "videosIcon", "galleryIcon", "newsIcon", "guideIcon", "chairIcon", "fatwaIcon", "fatwasIcon", "aboutIcon", "chatIcon", "contactIcon"]
    
    
    @IBOutlet weak var sideMenuTV: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        sideMenuTV.separatorStyle = .none
        sideMenuTV.frame = CGRect(x: 0, y: (self.view.frame.size.height - 45 * CGFloat(titles.count)) / 2.0, width: self.view.frame.size.width, height: 45 * CGFloat(titles.count))
        sideMenuTV.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth]
        sideMenuTV.isOpaque = false
        sideMenuTV.backgroundColor = UIColor.clear
        sideMenuTV.backgroundView = nil
        sideMenuTV.isScrollEnabled = true
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SideMenuTVCell
        
        
        cell.label.font = UIFont(name: "GE SS Two", size: 15)
        cell.label.text = titles[indexPath.row]
        cell.icon.image = UIImage(named: images[indexPath.row])
        cell.icon.tintColor = UIColor.secondryColor()
        
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        cell.contentView.backgroundColor = UIColor.primaryColor()
        
        switch indexPath.row {
        case 0:
            
            
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: LandingVC())
            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 1:
            
            let mapListVC = MapListVC()
            mapListVC.mapListType = true
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: mapListVC)
            sideMenuViewController?.hideMenuViewController()
            
            break
        
        case 2:
            
            let mapListVC = MapListVC()
            mapListVC.mapListType = false
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: mapListVC)
            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 3:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: TimelineVC())
            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 4:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: VideoVC())
            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 5:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: GalleryVC())
            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 6:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: NewsVC())
   	         sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 7:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: GuideVC())
            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 8:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: ChairOrderVC())
            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 9:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: FatwaVC())
            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 10:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: FatawyAnswersVC())
            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 11:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: AboutVC())
            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 12:
            var chatVC: UIViewController?
            let chat: Chat = {
                let chat = Chat()
                chat.type = "bot"
                chat.targetId = "89757"
                chat.chatId = chat.type + "_" + chat.targetId
                chat.title = "Chat"
                chat.detail = "bot"
                return chat
            }()
            
            chatVC = ChatVC(chat: chat)

            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: chatVC!)
            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 13:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: ContactVC())
            sideMenuViewController?.hideMenuViewController()
            
            break
        
        default:
            break
        }
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }

    
}





