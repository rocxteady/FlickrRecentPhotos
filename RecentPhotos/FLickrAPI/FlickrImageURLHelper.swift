//
//  FlickrImageURLHelper.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrImageURLHelper {
    
    class func createBuddyImageURLString(iconFarm: Int, iconServer: String, nsid: String) -> String {
        return "http://farm\(iconFarm).staticflickr.com/" + iconServer + "/buddyicons/" + nsid + ".jpg"
    }
    
}


