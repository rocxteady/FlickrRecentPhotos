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
    
    private(set) var currentPage = 0
    
    private(set) var totalPageCount: Int?
    
    let photoList = Variable<[FlickrPhoto]>([FlickrPhoto]())

    let requestStartedSubject = PublishSubject<Void>()
    
    let errorReceivedSubject = PublishSubject<String>()
    
    let requestCompletedSubject = PublishSubject<Void>()
    
    func getRecentPhotos() {
        let request = FlickrRecentPhotosRequest()
        let parameters = FlickrRecentPhotosRequestParams()
        parameters.page = self.currentPage + 1
        request.parameters = parameters
        self.requestStartedSubject.onNext(())
        self.disposable = request.start().subscribe(onNext: { [weak self] (response) in
            self?.photoList.value = response.photos?.photoList ?? [FlickrPhoto]()
            self?.currentPage = response.photos?.page ?? 0
            self?.totalPageCount = response.photos?.pages
        }, onError: { [weak self] (error) in
            self?.errorReceivedSubject.onNext(error.localizedDescription)
            self?.disposable?.dispose()
        }, onCompleted: { [weak self] in
            self?.requestCompletedSubject.onNext(())
            self?.disposable?.dispose()
        })
    }
    
}
