//
//  ImageDownloader.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift

class FlickrImageDownloader {
    
    private let downloader = KingfisherManager.shared
    
    private var currentDownloadTask: DownloadTask?
    
    func download(imageURLString: String, cacheKey: String? = nil) -> Observable<UIImage> {
        return Observable<UIImage>.create({ (observer) -> Disposable in
            guard let imageURL = URL(string: imageURLString) else {
                observer.onError(ErrorHelper.crateError(type: .noData))
                return Disposables.create()
            }
            let imageResource = ImageResource(downloadURL: imageURL, cacheKey: cacheKey)
            let options: KingfisherOptionsInfo = [.callbackQueue(.mainAsync)]
            self.currentDownloadTask = self.downloader.retrieveImage(with: imageResource, options: options, completionHandler: { (result) in
                switch result {
                case .success(let value):
                    observer.onNext(value.image)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            })
            return Disposables.create()
        })
    }
    
    func cancel() {
        if let task = self.currentDownloadTask {
            task.cancel()
        }
    }
    
}

extension FlickrImageDownloader {
    
    class func isCached(forKey key: String) -> Bool {
        
        return ImageCache.default.isCached(forKey: key)
        
    }
    
    class func retrieveImageFromCache(forKey key: String) -> Observable<UIImage> {
        return Observable<UIImage>.create({ (observer) -> Disposable in
            ImageCache.default.retrieveImage(forKey: key, completionHandler: { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let value):
                        observer.onNext(value.image!)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            })
            return Disposables.create()
        })
    }
    
}
