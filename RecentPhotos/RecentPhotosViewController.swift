//
//  ViewController.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RecentPhotosViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()
    
    let viewModel = RecentPhotosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupRx()
        getRecentPhotos()
    }

    private func setupRx() {
        self.viewModel.photoList.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: PhotoCell.identifier, cellType: PhotoCell.self)) { (row, model, cell) in
            
        }.disposed(by: self.disposeBag)
        self.viewModel.requestStartedSubject
            .asObservable()
            .subscribe(onNext: { () in
                print("Started")
            })
        .disposed(by: self.disposeBag)
        self.viewModel.requestCompletedSubject
            .asObservable()
            .subscribe(onNext: { () in
                print("Completed")
            })
            .disposed(by: self.disposeBag)
        self.viewModel.errorReceivedSubject
            .asObservable()
            .subscribe(onNext: { (error) in
                print(error)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func getRecentPhotos() {
        self.viewModel.getRecentPhotos()
    }

}

