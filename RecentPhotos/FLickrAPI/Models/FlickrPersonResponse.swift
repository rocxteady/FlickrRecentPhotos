//
//  FlickrPersonResponse.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrPersonResponse: FlickrBaseResponse {
    
    var person: FlickrPerson?
    
    private enum CodingKeys: String, CodingKey {
        
        case person = "person"
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        person = try container.decodeIfPresent(FlickrPerson.self, forKey: CodingKeys.person)
        try super.init(from: decoder)
    }
    
}
