//
//  FlickrPhoto.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrPhoto: Decodable {
    
    var id: String?
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Int?
    var title: String?
    var dateTaken: String?
    var ownername: String?
    var iconServer: String?
    var iconFarm: Int?
    var views: String?
    var tags: String?
    var urlS: String?
    var heightS: String?
    var widthS: String?
    var photoURL: String? {
        get {
            if let farm = self.farm, let server = self.server, let id = self.id, let secret = self.secret, farm > 0, server != "0" {
                return FlickrImageURLHelper.createImageURLString(farm: farm, server: server, id: id, secret: secret)
            }
            return nil
        }
    }
    var ownerPhotoURL: String? {
        get {
            if let iconFarm = self.iconFarm, let iconServer = self.iconServer, let nsid = self.owner, iconFarm > 0, iconServer != "0" {
                return FlickrImageURLHelper.createBuddyImageURLString(iconFarm: iconFarm, iconServer: iconServer, nsid: nsid)
            }
            return nil
        }
    }
    var tagArray: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case owner = "owner"
        case secret = "secret"
        case server = "server"
        case farm = "farm"
        case title = "title"
        case dateTaken = "datetaken"
        case ownername = "ownername"
        case iconServer = "iconserver"
        case iconFarm = "iconfarm"
        case views = "views"
        case tags = "tags"
        case urlS = "url_s"
        case heightS = "height_s"
        case widthS = "width_s"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        owner = try container.decodeIfPresent(String.self, forKey: .owner)
        secret = try container.decodeIfPresent(String.self, forKey: .secret)
        server = try container.decodeIfPresent(String.self, forKey: .server)
        farm = try container.decodeIfPresent(Int.self, forKey: .farm)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        dateTaken = try container.decodeIfPresent(String.self, forKey: .dateTaken)
        ownername = try container.decodeIfPresent(String.self, forKey: .ownername)
        iconServer = try container.decodeIfPresent(String.self, forKey: .iconServer)
        iconFarm = try container.decodeIfPresent(Int.self, forKey: .iconFarm)
        views = try container.decodeIfPresent(String.self, forKey: .views)
        tags = try container.decodeIfPresent(String.self, forKey: .tags)
        if tags != nil {
            self.tagArray = tags?.components(separatedBy: " ")
        }
        urlS = try container.decodeIfPresent(String.self, forKey: .urlS)
        heightS = try container.decodeIfPresent(String.self, forKey: .heightS)
        widthS = try container.decodeIfPresent(String.self, forKey: .widthS)
       
    }
    
}
