//
//  FlickrPhotosResponse.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrPhotosResponse: FlickrBaseResponse {
    
    var photos: FlickrPhotos?
    
    private enum CodingKeys: String, CodingKey {
        
        case photos = "photos"
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        photos = try container.decodeIfPresent(FlickrPhotos.self, forKey: CodingKeys.photos)
        try super.init(from: decoder)
    }
    
}
