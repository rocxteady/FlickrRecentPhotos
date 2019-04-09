//
//  FlickrPhotoSearchRequestParams.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrPhotoSearchRequestParams: FlickrBaseParams {
    
    var page = 0
    
    var perPage = 50
    
    var sort = "interestingness-desc"
    
    var safeSearch = 1
    
    var media = "photos"
    
    var extras = "icon_server,tags,views,date_taken,owner_name,url_s,height_s,width_s"
    
    override init() {
        super.init()
        self.method = .photoSearch
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case page = "page"
        case perPage = "per_page"
        case sort = "sort"
        case safeSearch = "safe_search"
        case media = "media"
        case extras = "extras"

    }
    
    override func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(page, forKey: CodingKeys.page)
        try container.encodeIfPresent(sort, forKey: CodingKeys.sort)
        try container.encodeIfPresent(perPage, forKey: CodingKeys.perPage)
        try container.encodeIfPresent(safeSearch, forKey: CodingKeys.safeSearch)
        try container.encodeIfPresent(media, forKey: CodingKeys.media)
        try container.encodeIfPresent(extras, forKey: CodingKeys.extras)

        try super.encode(to: encoder)
        
    }
    
}
