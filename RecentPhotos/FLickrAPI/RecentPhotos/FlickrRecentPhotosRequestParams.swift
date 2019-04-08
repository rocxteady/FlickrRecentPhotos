//
//  FlickrRecentPhotosRequestParams.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrRecentPhotosRequestParams: FlickrBaseParams {
    
    var page = 0
    
    var extras = "url_o,height_o,width_o,url_z,height_z,width_z"
    
    private enum CodingKeys: String, CodingKey {
        
        case page = "page"
        
    }
    
    override func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(page, forKey: CodingKeys.page)
        try super.encode(to: encoder)
        
    }
    
}
