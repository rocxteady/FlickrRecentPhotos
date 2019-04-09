//
//  FlickrPage.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrPage: Decodable {
    
    var page = 1
    
    var pages = 10
    
    var perPage = 100
    
    var total = "1000"
    
    private enum CodingKeys: String, CodingKey {
     
        case page = "page"
        case pages = "pages"
        case perPage = "perpage"
        case total = "total"
        
    }
    
}
