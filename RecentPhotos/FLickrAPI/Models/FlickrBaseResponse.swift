//
//  FlickrBaseResponse.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

enum FlickrResponseStat: String, Decodable {
    
    case ok = "ok"
    case fail = "fail"
    
}

class FlickrBaseResponse: Decodable {
    
    var code: Int?
    
    var message: String?
    
    var stat: FlickrResponseStat = .fail
    
}
