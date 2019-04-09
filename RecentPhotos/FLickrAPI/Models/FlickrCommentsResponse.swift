//
//  FlickrCommentsResponse.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrCommentsResponse: FlickrBaseResponse {
    
    var comments: FlickrComments?
    
    private enum CodingKeys: String, CodingKey {
        
        case comments = "comments"
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        comments = try container.decodeIfPresent(FlickrComments.self, forKey: CodingKeys.comments)
        try super.init(from: decoder)
    }
    
}
