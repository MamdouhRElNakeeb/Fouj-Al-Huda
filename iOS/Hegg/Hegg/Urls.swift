//
//  Urls.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 10/31/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import Foundation

class Urls {
    
    static let baseURL = "http://osamafayez.com/Hegg/hoda/"
    static let camp = baseURL + "getCampLocations.php"
    static let gather = baseURL + "getGatherLocations.php"
    static let timeline = baseURL + "getTimeline.php"
    static let youtubePLid = "PLULt7R-fsx1GBS3c2bJ7Afy9p1XSiJCMJ"
    static let googleAPIkey = "AIzaSyAaKC-V6JT2M0iP6NUm3aXWkHBElCySfxQ"
    static let videos = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=" + youtubePLid + "&maxResults=30&key=" + googleAPIkey
    static let gallery = baseURL + "gallery.php"
    static let photosDir = baseURL + "Gallery/"
    static let chairOrder = baseURL + "chairOrder.php"
    static let fatwaAsk = baseURL + "fatwaRequest.php"
    static let fatawyAnswers = baseURL + "getFatawy.php"
    static let news = baseURL + "getNews.php"
    static let guide = baseURL + "getGuide.php"
    static let chatGet = baseURL + "getChat.php"
    static let chatSend = baseURL + "sendMsg.php"
    static let contactUS = baseURL + "contactMsg.php"
    
    // Social Media
    static let fb = "https://www.facebook.com/peekssolutions/"
    static let twitter = "https://twitter.com/peekssolutions"
    static let website = "http://foujalhuda.com"
    
}
