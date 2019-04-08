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
    var isPublic: Int?
    var isFriend: Int?
    var isFamily: Int?
    var license: String?
    var description: FlickrDescription?
    var dateUpload: String?
    var lastUpdate: String?
    var dateTaken: String?
    var dateTakenUnknown: String?
    var ownername: String?
    var iconServer: String?
    var iconFarm: Int?
    var views: String?
    var tags: String?
    var machineTags: String?
    var originalSecret: String?
    var originalFormat: String?
    var latitude: Int?
    var longitude: Int?
    var accuracy: Int?
    var context: Int?
    var media: String?
    var mediaStatus: String?
    var urlSq: String?
    var heightSq: Int?
    var widthSq: Int?
    var urlT: String?
    var heightT: String?
    var widthT: String?
    var urlS: String?
    var heightS: String?
    var widthS: String?
    var urlQ: String?
    var heightQ: String?
    var widthQ: String?
    var urlM: String?
    var heightM: String?
    var widthM: String?
    var urlN: String?
    var heightN: String?
    var widthN: Int?
    var urlZ: String?
    var heightZ: String?
    var widthZ: String?
    var urlC: String?
    var heightC: String?
    var widthC: Int?
    var urlL: String?
    var heightL: String?
    var widthL: String?
    var urlO: String?
    var heightO: String?
    var widthO: String?
    var photoURL: String? {
        get {
            if let farm = self.farm, let server = self.server, let id = self.id, let secret = self.secret, farm > 0, server != "0" {
                return FlickrImageURLHelper.createImageURLString(farm: farm, server: server, id: id, secret: secret)
            }
            return nil
        }
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case owner = "owner"
        case secret = "secret"
        case server = "server"
        case farm = "farm"
        case title = "title"
        case isPublic = "ispublic"
        case isFriend = "isfriend"
        case isFamily = "isfamily"
        case license = "license"
        case description = "description"
        case dateUpload = "dateupload"
        case lastUpdate = "lastupdate"
        case dateTaken = "datetaken"
        case dateTakenUnknown = "datetakenunknown"
        case ownername = "ownername"
        case iconServer = "iconserver"
        case iconFarm = "iconfarm"
        case views = "views"
        case tags = "tags"
        case machineTags = "machine_tags"
        case originalSecret = "originalsecret"
        case originalFormat = "originalformat"
        case latitude = "latitude"
        case longitude = "longitude"
        case accuracy = "accuracy"
        case context = "context"
        case media = "media"
        case mediaStatus = "media_status"
        case urlSq = "url_sq"
        case heightSq = "height_sq"
        case widthSq = "width_sq"
        case urlT = "url_t"
        case heightT = "height_t"
        case widthT = "width_t"
        case urlS = "url_s"
        case heightS = "height_s"
        case widthS = "width_s"
        case urlQ = "url_q"
        case heightQ = "height_q"
        case widthQ = "width_q"
        case urlM = "url_m"
        case heightM = "height_m"
        case widthM = "width_m"
        case urlN = "url_n"
        case heightN = "height_n"
        case widthN = "width_n"
        case urlZ = "url_z"
        case heightZ = "height_z"
        case widthZ = "width_z"
        case urlC = "url_c"
        case heightC = "height_c"
        case widthC = "width_c"
        case urlL = "url_l"
        case heightL = "height_l"
        case widthL = "width_l"
        case urlO = "url_o"
        case heightO = "height_o"
        case widthO = "width_o"
    }
    
}
