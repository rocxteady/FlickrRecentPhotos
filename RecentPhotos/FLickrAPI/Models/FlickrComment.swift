//
//  FlickrComment.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrComment: Decodable {
    
    var id : String?
    var author : String?
    var authorName : String?
    var iconServer : String?
    var iconFarm : Int?
    var permalink : String?
    var pathAlias : String?
    var realName : String?
    var content : String?
    var dateCreateString: String?
    var dateCreate: String? {
        get {
            if let dateCreateString = dateCreateString {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                if let doubleDate = TimeInterval(dateCreateString) {
                    let date = Date(timeIntervalSince1970: doubleDate)
                    return dateFormatter.string(from: date)
                }
                return nil
            }
            return nil
        }
    }
    var photoURL: String? {
        get {
            if let iconFarm = self.iconFarm, let iconServer = self.iconServer, let author = self.author, iconFarm > 0, iconServer != "0" {
                return FlickrImageURLHelper.createBuddyImageURLString(iconFarm: iconFarm, iconServer: iconServer, nsid: author)
            }
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case author = "author"
        case authorName = "authorname"
        case iconServer = "iconserver"
        case iconFarm = "iconfarm"
        case pathAlias = "path_alias"
        case permalink = "permalink"
        case realName = "realname"
        case dateCreateString = "datecreate"
        case content = "_content"
        
    }
    
}
