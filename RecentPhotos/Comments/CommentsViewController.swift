//
//  CommentsViewController.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 9.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import UIKit
import RxSwift

class CommentsViewController: UIViewController {
    
    //Private properties
    @IBOutlet private weak var tableView: UITableView!
    
    private var activityIndicator: UIActivityIndicatorView!
    
    private let disposeBag = DisposeBag()
    
    private var viewModel: CommentsViewModel!
    
    //Public properties
    var photoID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel = CommentsViewModel(photoID: self.photoID!)
        self.activityIndicator = UIActivityIndicatorView(style: .gray)
        self.activityIndicator.hidesWhenStopped = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicator)
        self.tableView.refreshControl = UIRefreshControl(frame: CGRect.zero)
        self.tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.estimatedRowHeight = 135.0
        self.tableView.rowHeight = UITableView.automaticDimension
        setupRx()
        getComments()
    }
    
    private func setupRx() {
        //Data
        self.viewModel.commentList.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: PhotoCell.identifier, cellType: CommentCell.self)) { (row, comment, cell) in
            cell.load(comment: comment)
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
        
    }
    
    @objc private func refresh() {
        getComments(shouldReset: true)
    }
    
    private func getComments(shouldReset: Bool = false) {
        self.viewModel.getComments(shouldReset: shouldReset)
    }
    
}


//MARK: Error Handling
extension CommentsViewController {
    
    func handleError(error: String) {
        let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (action) in
            self.getComments()
        }))
    }
    
}
