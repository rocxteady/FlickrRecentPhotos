//
//  FlickrDescription.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrDescription: Decodable {
    
    var content: String?
    
    private enum CodingKeys: String, CodingKey {
        
        case content = "_content"
        
    }
    
    
}
