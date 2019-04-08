//
//  ViewController.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import UIKit
import RxSwift

class RecentPhotosViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let request = FlickrRecentPhotosRequest()
        let x = request.start()
        x.asObservable().subscribe(onNext: { (response) in
            print(response)
        },onError: { (error) in
            print(error.localizedDescription)
        }, onCompleted: {
            
        }).disposed(by: self.disposeBag)
    }


}

