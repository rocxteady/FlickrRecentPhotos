//
//  FlickrCommentsRequestParams.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrCommentsRequestParams: FlickrBaseParams {
    
    let photoID: String

    init(photoID: String) {
        self.photoID = photoID
        super.init()
        self.method = .photoComments
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case photoID = "photo_id"
        
    }
    
    override func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(photoID, forKey: CodingKeys.photoID)
        try super.encode(to: encoder)
        
    }
    
}
