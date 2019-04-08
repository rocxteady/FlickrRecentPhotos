//
//  FlickrPerson.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrPerson: Decodable {
    
    var id : String?
    var nsid : String?
    var isPro : Int?
    var canBuyPro : Int?
    var iconServer : String?
    var iconFarm : Int?
    var pathAlias : String?
    var hasStats : String?
    var username : FlickrDescription?
    var realName : FlickrDescription?
    var description : FlickrDescription?
    var photosURL : FlickrDescription?
    var profileURL : FlickrDescription?
    var mobileURL : FlickrDescription?
    var photos : FlickrPersonPhotos?
    var photoURL: String? {
        get {
            if let iconFarm = self.iconFarm, let iconServer = self.iconServer, let nsid = self.nsid, iconFarm > 0, iconServer != "0" {
                return FlickrImageURLHelper.createBuddyImageURLString(iconFarm: iconFarm, iconServer: iconServer, nsid: nsid)
            }
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case nsid = "nsid"
        case isPro = "ispro"
        case canBuyPro = "can_buy_pro"
        case iconServer = "iconserver"
        case iconFarm = "iconfarm"
        case pathAlias = "path_alias"
        case hasStats = "has_stats"
        case username = "username"
        case realName = "realname"
        case description = "description"
        case photosURL = "photosurl"
        case profileURL = "profileurl"
        case mobileURL = "mobileurl"
        case photos = "photos"
        
    }
    
    init() {
        
    }
    
}

class FlickrPersonPhotos: Decodable {
    
    var firstDateTaken: FlickrDescription?
    var firstDate: FlickrDescription?
    var count: FlickrDescriptionInt?
    
    enum CodingKeys: String, CodingKey {
        
        case firstDateTaken = "firstdatetaken"
        case firstDate = "firstdate"
        case count = "count"

    }
    
}
