//
//  FlickrAPIMethod.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

enum FlickrAPIMethod: String, Encodable {
    
    case recentPhotos = "flickr.photos.getRecent"
    case personInfo = "flickr.people.getInfo"
    
}
