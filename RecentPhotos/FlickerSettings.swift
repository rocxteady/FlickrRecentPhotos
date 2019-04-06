//
//  FlickerSettings.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

struct FlickrSettings {
    
    static private(set) var sharedSettings: FlickrSettings!
    
    let apiKey: String
    
    private init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    static func initalize(with apiKey: String) {
        FlickrSettings.sharedSettings = FlickrSettings(apiKey: apiKey)
    }
    
}
