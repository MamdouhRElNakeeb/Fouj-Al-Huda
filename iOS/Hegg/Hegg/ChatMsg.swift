//
//  ChatMsg.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 8/21/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Foundation
import NoChat

enum MessageDeliveryStatus {
    case Idle
    case Delivering
    case Delivered
    case Failure
    case Read
}

class Message: NSObject, NOCChatItem {
    
    var msgId: String = UUID().uuidString
    var msgType: String = "Text"
    
    var senderId: String = ""
    var date: Date = Date()
    var text: String = ""
    
    var isOutgoing: Bool = true
    var deliveryStatus: MessageDeliveryStatus = .Idle
    
    public func uniqueIdentifier() -> String {
        return self.msgId;
    }
    
    public func type() -> String {
        return self.msgType
    }
    
    init(msgId: String, text: String, isOutgoing: Bool, deliveryStatus: MessageDeliveryStatus) {
        
        self.msgId = msgId
        self.text = text
        self.isOutgoing = isOutgoing
        self.deliveryStatus = deliveryStatus
    }
    
    init(text: String) {
        self.text = text
    }
}
