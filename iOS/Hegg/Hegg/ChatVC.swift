//
//  ChatVC.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/21/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import NoChat
import Alamofire

class ChatVC: NOCChatViewController, UINavigationControllerDelegate, MessageManagerDelegate, TGChatInputTextPanelDelegate, TGTextMessageCellDelegate {
    
    var titleView = TGTitleView()
    var avatarButton = TGAvatarButton()
    
    var messageManager = MessageManager.manager
    var layoutQueue = DispatchQueue(label: "com.little2s.nochat-example.tg.layout", qos: DispatchQoS(qosClass: .default, relativePriority: 0))
    
    let chat: Chat
    
    // MARK: Overrides
    
    override class func cellLayoutClass(forItemType type: String) -> Swift.AnyClass? {
        if type == "Text" {
            return TGTextMessageCellLayout.self
        } else if type == "Date" {
            return TGDateMessageCellLayout.self
        } else if type == "System" {
            return TGSystemMessageCellLayout.self
        } else {
            return nil
        }
    }
    
    override class func inputPanelClass() -> Swift.AnyClass? {
        return TGChatInputTextPanel.self
    }
    
    override func registerChatItemCells() {
        collectionView?.register(TGTextMessageCell.self, forCellWithReuseIdentifier: TGTextMessageCell.reuseIdentifier())
        collectionView?.register(TGDateMessageCell.self, forCellWithReuseIdentifier: TGDateMessageCell.reuseIdentifier())
        collectionView?.register(TGSystemMessageCell.self, forCellWithReuseIdentifier: TGSystemMessageCell.reuseIdentifier())
    }
    
    init(chat: Chat) {
        self.chat = chat
        super.init(nibName: nil, bundle: nil)
        messageManager.addDelegate(self)
        registerContentSizeCategoryDidChangeNotification()
        //setupNavigationItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        messageManager.removeDelegate(self)
        unregisterContentSizeCategoryDidChangeNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView?.image = UIImage(named: "TGWallpaper")!
        //navigationController?.delegate = self
        
        let image = UIImage(named:"sideMenuIcon")?.withRenderingMode(.alwaysTemplate)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(SSASideMenu.presentRightMenuViewController))
        
        self.navigationItem.leftBarButtonItem?.title = "رجوع"
        
        let labelTitle = UILabel()
        labelTitle.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        labelTitle.text = "دردشة"
        labelTitle.font = UIFont(name: "GE SS Two", size: 17)
        labelTitle.textColor = UIColor.secondryColor()
        self.navigationItem.titleView = labelTitle
        
        
        let whiteNB = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        whiteNB.backgroundColor = UIColor.primaryColor()
        self.view.addSubview(whiteNB)

        
        loadMessages()
    }
    
    // MARK: TGChatInputTextPanelDelegate
    
    func inputTextPanel(_ inputTextPanel: TGChatInputTextPanel, requestSendText text: String) {
        let msg = Message(text: text)
        //msg.text = text
        sendMessage(msg)
    }
    
    // MARK: TGTextMessageCellDelegate
    
    func didTapLink(cell: TGTextMessageCell, linkInfo: [AnyHashable: Any]) {
        inputPanel?.endInputting(true)
        
        guard let command = linkInfo["command"] as? String else { return }
        let msg = Message(text: command)
//        msg.text = command
        //sendMessage(msg)
    }
    
    // MARK: MessageManagerDelegate
    
    func didReceiveMessages(messages: [Message], chatId: String) {
        if isViewLoaded == false { return }
        
        if chatId == chat.chatId {
            addMessages(messages, scrollToBottom: true, animated: true)
            
            SoundManager.manager.playSound(name: "notification.caf", vibrate: false)
        }
    }
    
    // MARK: UINavigationControllerDelegate
    /*
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard viewController is ChatsViewController else {
            return
        }
        
        isInControllerTransition = true
        
        guard let tc = navigationController.topViewController?.transitionCoordinator else { return }
        tc.notifyWhenInteractionEnds { [weak self] (context) in
            guard let strongSelf = self else { return }
            if context.isCancelled {
                strongSelf.isInControllerTransition = false
            }
        }
    }
    */
    
    // MARK: Private
    
    private func setupNavigationItems() {
        titleView.title = chat.title
        titleView.detail = chat.detail
        navigationItem.titleView = titleView
        
        let spacerItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacerItem.width = -12
        
        let rightItem = UIBarButtonItem(customView: avatarButton)
        
        navigationItem.rightBarButtonItems = [spacerItem, rightItem]
    }
    
    private func loadMessages() {
        
        let utils: Utils = Utils()
        
        if !utils.isConnectedToNetwork(){
            let alert = UIAlertController(title: "تنبيه", message: "يوجد مشكلة فى الإتصال بالإنترنت", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "حاول مرة أخرى", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        layouts.removeAllObjects()
        
        let chatUrl = "http://hegg.nakeeb.me/API/qassem/getChat.php"
        
        let parameters: Parameters=[
            "userID": UserDefaults.standard.string(forKey: "userID") ?? 1
        ]
        
        Alamofire.request(chatUrl, method: .post, parameters: parameters)
            .responseJSON{
                
                response in
                
                print(response)
                
                if let result = response.result.value {
                    
                    
                    let chatJSONArr = result as! NSArray
                    
                    var msgs = [Message]()
                    
                    let userID = UserDefaults.standard.string(forKey: "userID")!
                    
                    for chatMsgObj in chatJSONArr{
                        
                        var isOutgoing = true
                        
                        if (chatMsgObj as AnyObject).value(forKey: "fromUserID") as! String == userID{
                            isOutgoing = true
                        }
                        else{
                            isOutgoing = false
                        }
                        
                        msgs.append(Message.init(msgId: (chatMsgObj as AnyObject).value(forKey: "id") as! String,
                                                              text: (chatMsgObj as AnyObject).value(forKey: "msg") as! String,
                                                              isOutgoing: isOutgoing,
                                                              deliveryStatus: MessageDeliveryStatus.Delivered))
                    }
                
                    
                    self.addMessages(msgs, scrollToBottom: true, animated: false)
                    
                }
        }
        /*
        messageManager.fetchMessages(withChatId: chat.chatId) { [weak self] (msgs) in
            if let strongSelf = self {
                strongSelf.addMessages(msgs, scrollToBottom: true, animated: false)
            }
        }
        */
    }
    
    private func sendMessage(_ message: Message) {
        message.isOutgoing = true
        message.senderId = UserDefaults.standard.string(forKey: "userID")!
        message.deliveryStatus = .Delivering
        
        addMessages([message], scrollToBottom: true, animated: true)
        
        //messageManager.sendMessage(message, toChat: chat)
        
        let chatUrl = "http://hegg.nakeeb.me/API/qassem/sendMsg.php"
        
        let parameters: Parameters=[
            "userID": message.senderId,
            "msg": message.text
        ]
        
        Alamofire.request(chatUrl, method: .post, parameters: parameters)
            .responseJSON{
                
                response in
                
                print(response)
                
                if let result = response.result.value {
                    
                    
                    let chatMsgObj = result as! NSObject
                    
                    if (chatMsgObj as AnyObject).value(forKey: "msg") as! String == "success"{
                        message.deliveryStatus = MessageDeliveryStatus.Delivered
                    }
                    else{
                        message.deliveryStatus = MessageDeliveryStatus.Failure
                    }
                    self.loadMessages()
                    
                }
        }

        
        SoundManager.manager.playSound(name: "sent.caf", vibrate: false)
    }
    
    private func addMessages(_ messages: [Message], scrollToBottom: Bool, animated: Bool) {
        layoutQueue.async { [weak self] in
            guard let strongSelf = self else { return }
            let indexes = IndexSet(integersIn: 0..<messages.count)
            
            var layouts = [NOCChatItemCellLayout]()
            
            for message in messages {
                let layout = strongSelf.createLayout(with: message)!
                layouts.insert(layout, at: 0)
            }
            
            DispatchQueue.main.async {
                strongSelf.insertLayouts(layouts, at: indexes, animated: animated)
                if scrollToBottom {
                    strongSelf.scrollToBottom(animated: animated)
                }
            }
        }
    }
    
    // MARK: Dynamic font support
    
    private func registerContentSizeCategoryDidChangeNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleContentSizeCategoryDidChanged(notification:)), name: .UIContentSizeCategoryDidChange, object: nil)
    }
    
    private func unregisterContentSizeCategoryDidChangeNotification() {
        NotificationCenter.default.removeObserver(self, name: .UIContentSizeCategoryDidChange, object: nil)
    }
    
    @objc private func handleContentSizeCategoryDidChanged(notification: Notification) {
        if isViewLoaded == false {
            return
        }
        
        if layouts.count == 0 {
            return
        }
        
        // ajust collection display
        
        let collectionViewSize = containerView!.bounds.size
        
        let anchorItem = calculateAnchorItem()
        
        for layout in layouts {
            (layout as! NOCChatItemCellLayout).calculate()
        }
        
        collectionLayout!.invalidateLayout()
        
        let cellLayouts = layouts.map { $0 as! NOCChatItemCellLayout }
        
        var newContentHeight = CGFloat(0)
        let newLayoutAttributes = collectionLayout!.layoutAttributes(for: cellLayouts, containerWidth: collectionViewSize.width, maxHeight: CGFloat.greatestFiniteMagnitude, contentHeight: &newContentHeight)
        
        var newContentOffset = CGPoint.zero
        newContentOffset.y = -collectionView!.contentInset.top
        if anchorItem.index >= 0 && anchorItem.index < newLayoutAttributes.count {
            let attributes = newLayoutAttributes[anchorItem.index]
            newContentOffset.y += attributes.frame.origin.y - floor(anchorItem.offset * attributes.frame.height)
        }
        newContentOffset.y = min(newContentOffset.y, newContentHeight + collectionView!.contentInset.bottom - collectionView!.frame.height)
        newContentOffset.y = max(newContentOffset.y, -collectionView!.contentInset.top)
        
        collectionView!.reloadData()
        
        collectionView!.contentOffset = newContentOffset
        
        // fix navigation items display
        //setupNavigationItems()
    }
    
    typealias AnchorItem = (index: Int, originY: CGFloat, offset: CGFloat, height: CGFloat)
    private func calculateAnchorItem() -> AnchorItem {
        let maxOriginY = collectionView!.contentOffset.y + collectionView!.contentInset.top
        let previousCollectionFrame = collectionView!.frame
        
        var itemIndex = Int(-1)
        var itemOriginY = CGFloat(0)
        var itemOffset = CGFloat(0)
        var itemHeight = CGFloat(0)
        
        let cellLayouts = layouts.map { $0 as! NOCChatItemCellLayout }
        
        let previousLayoutAttributes = collectionLayout!.layoutAttributes(for: cellLayouts, containerWidth: previousCollectionFrame.width, maxHeight: CGFloat.greatestFiniteMagnitude, contentHeight: nil)
        
        for i in 0..<layouts.count {
            let attributes = previousLayoutAttributes[i]
            let itemFrame = attributes.frame
            
            if itemFrame.origin.y < maxOriginY {
                itemHeight = itemFrame.height
                itemIndex = i
                itemOriginY = itemFrame.origin.y
            }
        }
        
        if itemIndex != -1 {
            if itemHeight > 1 {
                itemOffset = (itemOriginY - maxOriginY) / itemHeight
            }
        }
        
        return (itemIndex, itemOriginY, itemOffset, itemHeight)
    }
    
}
