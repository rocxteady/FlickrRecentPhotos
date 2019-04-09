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
    
    var perPage = 50
    
    var extras = "icon_server,tags,views,date_taken,owner_name,url_s,height_s,width_s"
    
    private enum CodingKeys: String, CodingKey {
        
        case page = "page"
        case extras = "extras"
        case perPage = "per_page"
        
    }
    
    override func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(page, forKey: CodingKeys.page)
        try container.encodeIfPresent(extras, forKey: CodingKeys.extras)
        try container.encodeIfPresent(perPage, forKey: CodingKeys.perPage)
        try super.encode(to: encoder)
        
    }
    
}
