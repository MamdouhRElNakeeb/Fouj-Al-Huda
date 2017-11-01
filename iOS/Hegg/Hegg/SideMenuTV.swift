//
//  SideMenuTV.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 10/17/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class SideMenuTV: UITableViewController {

    
    
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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorStyle = .none
        self.tableView.frame = CGRect(x: 0, y: (self.view.frame.size.height - 45 * CGFloat(titles.count)) / 2.0, width: self.view.frame.size.width, height: 45 * CGFloat(titles.count))
        self.tableView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth]
        self.tableView.isOpaque = false
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.backgroundView = nil
        self.tableView.isScrollEnabled = true
        
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SideMenuTVCell
        
        
        cell.label.font = UIFont(name: "GE SS Two", size: 15)
        cell.label.text = titles[indexPath.row]
        cell.icon.image = UIImage(named: images[indexPath.row])
        cell.icon.tintColor = UIColor.secondryColor()
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sw = storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        self.view.window?.rootViewController = sw
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        cell.contentView.backgroundColor = UIColor.primaryColor()
        
        switch indexPath.row {
        case 0:
            
            
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "landing") as! LandingVC
            
            let navigationController = UINavigationController(rootViewController: newViewController)
            sw.pushFrontViewController(navigationController, animated: true)
            
//            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: LandingVC())
//            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 1:
            
            
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "mapList") as! MapListVC
            
            newViewController.mapListType = true
            let navigationController = UINavigationController(rootViewController: newViewController)
            sw.pushFrontViewController(navigationController, animated: true)
            
//            let mapListVC = MapListVC()
//            mapListVC.mapListType = true
//            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: mapListVC)
//            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 2:
            
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "mapList") as! MapListVC
            
            newViewController.mapListType = false
            let navigationController = UINavigationController(rootViewController: newViewController)
            sw.pushFrontViewController(navigationController, animated: true)
            
//            let mapListVC = MapListVC()
//            mapListVC.mapListType = false
//            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: mapListVC)
//            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 3:
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "timeline") as! TimelineVC
            let navigationController = UINavigationController(rootViewController: newViewController)
            sw.pushFrontViewController(navigationController, animated: true)
            
//            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: TimelineVC())
//            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 4:
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "videos") as! VideoVC
            let navigationController = UINavigationController(rootViewController: newViewController)
            sw.pushFrontViewController(navigationController, animated: true)
            
//            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: VideoVC())
//            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 5:
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "gallery") as! GalleryVC
            let navigationController = UINavigationController(rootViewController: newViewController)
            sw.pushFrontViewController(navigationController, animated: true)
            
//            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: GalleryVC())
//            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 6:
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "news") as! NewsVC
            let navigationController = UINavigationController(rootViewController: newViewController)
            sw.pushFrontViewController(navigationController, animated: true)
            
//            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: NewsVC())
//            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 7:
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "guide") as! GuideVC
            let navigationController = UINavigationController(rootViewController: newViewController)
            sw.pushFrontViewController(navigationController, animated: true)
            
//            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: GuideVC())
//            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 8:
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "chairOrder") as! ChairOrderVC
            let navigationController = UINavigationController(rootViewController: newViewController)
            sw.pushFrontViewController(navigationController, animated: true)
            
//            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: ChairOrderVC())
//            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 9:
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "fatwa") as! FatwaVC
            let navigationController = UINavigationController(rootViewController: newViewController)
            sw.pushFrontViewController(navigationController, animated: true)
            
//            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: FatwaVC())
//            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 10:
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "fatawy") as! FatawyAnswersVC
            let navigationController = UINavigationController(rootViewController: newViewController)
            sw.pushFrontViewController(navigationController, animated: true)
            
//            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: FatawyAnswersVC())
//            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 11:
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "about") as! AboutVC
            let navigationController = UINavigationController(rootViewController: newViewController)
            sw.pushFrontViewController(navigationController, animated: true)
            
//            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: AboutVC())
//            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 12:
//            var chatVC: UIViewController?
            let chat: Chat = {
                let chat = Chat()
                chat.type = "bot"
                chat.targetId = "89757"
                chat.chatId = chat.type + "_" + chat.targetId
                chat.title = "Chat"
                chat.detail = "bot"
                return chat
            }()
            
            let newViewController = ChatVC(chat: chat)

            let navigationController = UINavigationController(rootViewController: newViewController)
            sw.pushFrontViewController(navigationController, animated: true)
            
//            chatVC = ChatVC(chat: chat)
//
//            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: chatVC!)
//            sideMenuViewController?.hideMenuViewController()
            
            break
            
        case 13:
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "contact") as! ContactVC
            let navigationController = UINavigationController(rootViewController: newViewController)
            sw.pushFrontViewController(navigationController, animated: true)
            
//            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: ContactVC())
//            sideMenuViewController?.hideMenuViewController()
//
            break
            
        default:
            break
        }
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
 
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }

}
