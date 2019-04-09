//
//  FlickrComments.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrComments: Decodable {

    var photoID: String?
    var commentList: [FlickrComment]?
 
    private enum CodingKeys: String, CodingKey {

        case photoID = "photo_id"
        case commentList = "comment"
        
    }
    
}
