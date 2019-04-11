//
//  CommentsViewModel.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation
import RxSwift

class CommentsViewModel {
    
    //Private properties
    private let disposeBag = DisposeBag()
    
    private let photoID: String
    
    //Public properties
    let commentList = Variable<[FlickrComment]>([FlickrComment]())

    let requestStartedSubject = PublishSubject<Void>()
    
    let errorReceivedSubject = PublishSubject<String>()
    
    let requestCompletedSubject = PublishSubject<Void>()
    
    init(photoID: String) {
        self.photoID = photoID
    }
    
    func getComments(shouldReset: Bool = false) {
        if shouldReset {
            self.commentList.value = [FlickrComment]()
        }
        let request = FlickrCommentsRequest()
        let parameters = FlickrCommentsRequestParams(photoID: photoID)
        request.parameters = parameters
        self.requestStartedSubject.onNext(())
        request.start().subscribe(onNext: { [weak self] (response) in
            if let strongSelf = self, let commentList = response.comments?.commentList {
                strongSelf.commentList.value = commentList
            }
            if let strongSelf = self {
                strongSelf.requestCompletedSubject.onNext(())
            }
        }, onError: { [weak self] (error) in
            if let strongSelf = self {                strongSelf.errorReceivedSubject.onNext(error.localizedDescription)
            }
        })
        .disposed(by: self.disposeBag)
    }
    
}
