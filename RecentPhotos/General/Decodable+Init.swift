//
//  Decodable+Init.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation

extension Decodable {
    
    init(data: Data) throws {
        let jsonDecoder = JSONDecoder()
        self = try jsonDecoder.decode(Self.self, from: data)
    }
    
}
