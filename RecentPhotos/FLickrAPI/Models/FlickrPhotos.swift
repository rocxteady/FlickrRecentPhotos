//
//  FlickrPhotos.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrPhotos: FlickrPage {

    var photoList: [FlickrPhoto]?
 
    private enum CodingKeys: String, CodingKey {

        case photoList = "photo"
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        photoList = try container.decodeIfPresent([FlickrPhoto].self, forKey: CodingKeys.photoList)
        try super.init(from: decoder)
    }
    
}
