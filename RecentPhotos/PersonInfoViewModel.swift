//
//  PersonInfoViewModel.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import Foundation
import RxSwift

class PersonInfoViewModel {
    
    var personDisposable: Disposable?
    var imageDisposable: Disposable?
    
    let personID: String
    
    private var person: FlickrPerson? {
        didSet {
            if let person = self.person, let imageURLString = person.photoURL {
                getImage(imageURLString: imageURLString)
            }
        }
    }
    
    let request = FlickrPersonInfoRequest()
    
    var image = Variable<UIImage>(UIImage())

    let requestStartedSubject = PublishSubject<Void>()
    
    let errorReceivedSubject = PublishSubject<String>()
    
    let requestCompletedSubject = PublishSubject<Void>()
    
    init(personID: String) {
        self.personID = personID
        let parameters = FlickrPersonRequestParams(personID: self.personID)
        request.parameters = parameters
    }
    
    func getPersonInfo() {
        if FlickrImageDownloader.isCached(forKey: self.personID) {
            getImageFromCache(forKey: self.personID)
            return
        }
        self.requestStartedSubject.onNext(())
        self.personDisposable = request.start().subscribe(onNext: { [weak self] (response) in
            self?.person = response.person
        }, onError: { [weak self] (error) in
            self?.errorReceivedSubject.onNext(error.localizedDescription)
            self?.personDisposable?.dispose()
        }, onCompleted: { [weak self] in
            self?.requestCompletedSubject.onNext(())
            self?.personDisposable?.dispose()
        })
    }
    
    func stopGettingPersonInfo() {
        request.end()
    }
    
    private func getImage(imageURLString: String) {
        let downlader = FlickrImageDownloader()
        self.imageDisposable = downlader.download(imageURLString: imageURLString, cacheKey: self.personID)
            .subscribe(onNext: { [weak self] (image) in
                self?.image.value = image
            }, onError: { [weak self] (error) in
                self?.errorReceivedSubject.onNext(error.localizedDescription)
                self?.imageDisposable?.dispose()
            }, onCompleted: { [weak self] in
                self?.requestCompletedSubject.onNext(())
                self?.imageDisposable?.dispose()
            })
    }
    
    private func getImageFromCache(forKey key: String) {
        self.imageDisposable = FlickrImageDownloader.retrieveImageFromCache(forKey: key)
            .subscribe(onNext: { [weak self] (image) in
                self?.image.value = image
            }, onError: { [weak self] (error) in
                self?.errorReceivedSubject.onNext(error.localizedDescription)
                self?.imageDisposable?.dispose()
            }, onCompleted: { [weak self] in
                self?.requestCompletedSubject.onNext(())
                self?.imageDisposable?.dispose()
            })
    }
    
    deinit {
        if self.personDisposable != nil {
            self.personDisposable?.dispose()
        }
        if self.imageDisposable != nil {
            self.imageDisposable?.dispose()
        }
    }
    
}
