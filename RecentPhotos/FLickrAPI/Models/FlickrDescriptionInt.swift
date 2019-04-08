//
//  FlickrDescriptionInt.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrDescriptionInt: Decodable {
    
    var content: Int?
    
    private enum CodingKeys: String, CodingKey {
        
        case content = "_content"
        
    }
    
    
}
