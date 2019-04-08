//
//  RecentPhotosViewModel.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation
import RxSwift

class RecentPhotosViewModel {
    
    var disposable: Disposable?
    
    private var currentPage = 0
    
    private var totalPageCount: Int?
    
    private(set) var isFinished = false
    
    let photoList = Variable<[FlickrPhoto]>([FlickrPhoto]())

    let requestStartedSubject = PublishSubject<Void>()
    
    let errorReceivedSubject = PublishSubject<String>()
    
    let requestCompletedSubject = PublishSubject<Void>()
    
    func getRecentPhotos(shouldReset: Bool = false) {
        if shouldReset {
            self.photoList.value = [FlickrPhoto]()
        }
        let request = FlickrRecentPhotosRequest()
        let parameters = FlickrRecentPhotosRequestParams()
        parameters.page = self.currentPage + 1
        request.parameters = parameters
        self.requestStartedSubject.onNext(())
        self.disposable = request.start().subscribe(onNext: { [weak self] (response) in
            if let photoList = response.photos?.photoList {
                self?.photoList.value.append(contentsOf: photoList)
            }
            if let page = response.photos?.page {
                self?.currentPage = page
            }
            if let pages = response.photos?.pages {
                self?.totalPageCount = pages
            }
        }, onError: { [weak self] (error) in
            self?.errorReceivedSubject.onNext(error.localizedDescription)
            self?.disposable?.dispose()
        }, onCompleted: { [weak self] in
            self?.requestCompletedSubject.onNext(())
            self?.disposable?.dispose()
        })
    }
    
}
