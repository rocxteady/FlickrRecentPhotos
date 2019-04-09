//
//  PhotosViewModel.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation
import RxSwift

class PhotosViewModel {
    
    var disposable: Disposable?
    
    private var currentPage = 0
    
    private var totalPageCount: Int? {
        didSet {
            if let totalPageCount = self.totalPageCount, totalPageCount == currentPage {
                self.isFinished = true
            }
        }
    }
    
    private(set) var isFinished = false
    
    private(set) var isBusy = false
    
    var isSearchActive = false
    
    var searchTag: String?
    
    private let photoList = Variable<[FlickrPhoto]>([FlickrPhoto]())
    
    let filteredPhotoList = Variable<[FlickrPhoto]>([FlickrPhoto]())

    let requestStartedSubject = PublishSubject<Void>()
    
    let errorReceivedSubject = PublishSubject<String>()
    
    let requestCompletedSubject = PublishSubject<Void>()
    
    func getRecentPhotos(shouldReset: Bool = false) {
        if shouldReset {
            self.currentPage = 0
            self.totalPageCount = nil
            self.isFinished = false
            self.photoList.value = [FlickrPhoto]()
        }
        let request = FlickrPhotosRequest()
        let parameters = FlickrPhotoSearchRequestParams()
        parameters.page = self.currentPage + 1
        request.parameters = parameters
        self.requestStartedSubject.onNext(())
        self.isBusy = true
        self.disposable = request.start().subscribe(onNext: { [weak self] (response) in
            if let strongSelf = self, let photoList = response.photos?.photoList {
                strongSelf.photoList.value.append(contentsOf: photoList)
                strongSelf.search(tag: strongSelf.searchTag)
            }
            if let strongSelf = self, let page = response.photos?.page {
                strongSelf.currentPage = page
            }
            if let strongSelf = self, let pages = response.photos?.pages {
                strongSelf.totalPageCount = pages
            }
            if let strongSelf = self {
                strongSelf.isBusy = false
                strongSelf.requestCompletedSubject.onNext(())
                strongSelf.disposable?.dispose()
            }
        }, onError: { [weak self] (error) in
            if let strongSelf = self {
                strongSelf.isBusy = false
                strongSelf.errorReceivedSubject.onNext(error.localizedDescription)
                strongSelf.disposable?.dispose()
            }
        })
    }
    
    func search(tag: String?) {
        self.searchTag = tag
        self.isSearchActive = true
        if let tag = tag, tag.count > 0 {
            DispatchQueue.global().async {
                let searchResult = self.photoList.value.filter({ (photo) -> Bool in
                    if let tags = photo.tagArray {
                        return tags.contains(where: { (tagInArray) -> Bool in
                            return tagInArray.lowercased(with: Locale.current).hasPrefix(tag.lowercased(with: Locale.current))
                        })
                    }
                    return false
                })
                DispatchQueue.main.async(execute: {
                    self.filteredPhotoList.value = searchResult
                })
            } 
        }
        else {
            self.isSearchActive = false
            self.filteredPhotoList.value = self.photoList.value
        }
    }
    
}
