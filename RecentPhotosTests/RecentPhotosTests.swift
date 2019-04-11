//
//  RecentPhotosTests.swift
//  RecentPhotosTests
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import XCTest
import RxSwift
@testable import RecentPhotos

class RecentPhotosTests: XCTestCase {

    let disposeBag = DisposeBag()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEndingRequest() {
        let networkRequest = FlickrNetworkRequest()
        networkRequest.start()
        .subscribe()
        .dispose()
        XCTAssertNil(networkRequest.currentRequest, "Current request should be nil")
    }
    
    func testRequest() {
        let networkRequest = FlickrNetworkRequest()
        networkRequest.start()
            .subscribe()
            .disposed(by: self.disposeBag)
        XCTAssertNotNil(networkRequest.currentRequest, "Current request should not be nil")
    }
    
    func testRequestsResponse() {
        let testExpectation = expectation(description: "Request")
        let networkRequest = FlickrNetworkRequest()
        networkRequest.start()
            .subscribe(onNext: { (response) in
                XCTAssertTrue(response.stat == .ok, "Response stat should be ok")
                testExpectation.fulfill()
            }, onError: { (error) in
                XCTAssert(false, error.localizedDescription)
                testExpectation.fulfill()
            }
        )
        .disposed(by: self.disposeBag)
        waitForExpectations(timeout: 15, handler: nil)
    }

}
