//
//  FlickrBaseParams.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrBaseParams: Encodable {
    
    let format = "json"
    
    let noJSONCallback = 1
    
    var apiKey = FlickrSettings.sharedSettings.apiKey
    
    var method: FlickrAPIMethod = .recentPhotos
    
    
    private enum CodingKeys: String, CodingKey {
        
        case format = "format"
        case noJSONCallback = "nojsoncallback"
        case apiKey = "api_key"
        case method = "method"
        
    }
    
}
