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
        self.tableView.estimatedRowHeight = 135.0
        self.tableView.rowHeight = UITableView.automaticDimension
        setupRx()
        getRecentPhotos()
    }

    private func setupRx() {
        self.viewModel.photoList.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: PhotoCell.identifier, cellType: PhotoCell.self)) { (row, photo, cell) in
            cell.load(photo: photo)
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
        self.tableView.rx.setDelegate(self)
        .disposed(by: self.disposeBag)
    }
    
    private func getRecentPhotos() {
        self.viewModel.getRecentPhotos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photo" {
            let button = sender as! UIButton
            let point = button.convert(CGPoint.zero, to: self.tableView)
            if let indexPath = self.tableView.indexPathForRow(at: point) {
                let photoViewController = segue.destination as! PhotoViewController
                let photo = self.viewModel.photoList.value[indexPath.row]
                photoViewController.photoURLString = photo.photoURL
            }
        }
    }

}

extension RecentPhotosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.photoList.value.count - 1 {
            getRecentPhotos()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! PhotoCell
        cell.viewModel.stopGettingPersonInfo()
    }
    
}
