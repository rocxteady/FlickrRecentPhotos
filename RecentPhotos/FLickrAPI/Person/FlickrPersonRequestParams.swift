//
//  FlickrPersonRequestParams.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

class FlickrPersonRequestParams: FlickrBaseParams {
    
    let personID: String

    init(personID: String) {
        self.personID = personID
        super.init()
        self.method = .personInfo
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case personID = "user_id"
        
    }
    
    override func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(personID, forKey: CodingKeys.personID)
        try super.encode(to: encoder)
        
    }
    
}
