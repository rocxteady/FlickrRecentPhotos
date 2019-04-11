//
//  PhotosViewController.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 6.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PhotosViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private let searchBar = UISearchBar(frame: .zero)
    private var activityIndicator: UIActivityIndicatorView!

    private let disposeBag = DisposeBag()
    
    private let viewModel = PhotosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.searchBar.showsCancelButton = true
        self.navigationItem.titleView = self.searchBar
        self.activityIndicator = UIActivityIndicatorView(style: .gray)
        self.activityIndicator.hidesWhenStopped = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicator)
        self.tableView.refreshControl = UIRefreshControl(frame: CGRect.zero)
        self.tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.estimatedRowHeight = 135.0
        self.tableView.rowHeight = UITableView.automaticDimension
        setupRx()
        getRecentPhotos()
    }

    private func setupRx() {
        //Data
        self.viewModel.filteredPhotoList.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: PhotoCell.identifier, cellType: PhotoCell.self)) { (row, photo, cell) in
            cell.load(photo: photo)
        }.disposed(by: self.disposeBag)
        
        //Callbacks
        self.viewModel.requestStartedSubject
            .asObservable()
            .subscribe(onNext: { () in
                self.activityIndicator.startAnimating()
            })
        .disposed(by: self.disposeBag)
        self.viewModel.requestCompletedSubject
            .asObservable()
            .subscribe(onNext: { [weak self] () in
                self?.activityIndicator.stopAnimating()
                self?.tableView.refreshControl?.endRefreshing()
            })
            .disposed(by: self.disposeBag)
        self.viewModel.errorReceivedSubject
            .asObservable()
            .subscribe(onNext: { [weak self] (error) in
                self?.activityIndicator.stopAnimating()
                self?.tableView.refreshControl?.endRefreshing()
                self?.handleError(error: error)
            })
            .disposed(by: self.disposeBag)
        
        //UITableview Delegate
        self.tableView.rx.setDelegate(self)
        .disposed(by: self.disposeBag)
        
        //Search
        self.searchBar.rx.text.orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { (term) in
                self.viewModel.search(tag: term)
            })
            .disposed(by: self.disposeBag)

        self.searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { () in
                self.viewModel.isSearchActive = false
                self.searchBar.text = nil
                self.searchBar.resignFirstResponder()
            }).disposed(by: self.disposeBag)
        
    }
    
    @objc private func refresh() {
        getRecentPhotos(shouldReset: true)
    }
    
    private func getRecentPhotos(shouldReset: Bool = false) {
        self.viewModel.getRecentPhotos(shouldReset: shouldReset)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photo" {
            let button = sender as! UIButton
            let point = button.convert(CGPoint.zero, to: self.tableView)
            if let indexPath = self.tableView.indexPathForRow(at: point) {
                let photoViewController = segue.destination as! PhotoViewController
                let photo = self.viewModel.filteredPhotoList.value[indexPath.row]
                photoViewController.photoURLString = photo.photoURL
            }
        }
        else if segue.identifier == "comments" {
            let button = sender as! UIButton
            let point = button.convert(CGPoint.zero, to: self.tableView)
            if let indexPath = self.tableView.indexPathForRow(at: point) {
                let commentsViewController = segue.destination as! CommentsViewController
                let photo = self.viewModel.filteredPhotoList.value[indexPath.row]
                commentsViewController.photoID = photo.id
            }
        }
    }

}

//MARK: UITableView Delegate
extension PhotosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.filteredPhotoList.value.count - 1 && !self.viewModel.isFinished && !self.viewModel.isBusy && !self.viewModel.isSearchActive {
            getRecentPhotos()
        }
    }
    
}

//MARK: UIScrollView Delegate
extension PhotosViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
}

//MARK: Error Handling
extension PhotosViewController {
    
    func handleError(error: String) {
        let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (action) in
            self.getRecentPhotos()
        }))
    }
    
}
