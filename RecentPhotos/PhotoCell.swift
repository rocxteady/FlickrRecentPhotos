//
//  PhotoCell.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import UIKit
import RxSwift

class PhotoCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    var viewModel: PersonInfoViewModel!
    
    static let identifier = "PhotoCell"

    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerPhotoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }

    func load(photo: FlickrPhoto) {
        self.viewModel = PersonInfoViewModel(personID: photo.owner!)
        self.viewModel.image
        .asObservable()
            .subscribe(onNext: { [weak self] (image) in
                self?.ownerPhotoImageView.image = image
            })
        .disposed(by: self.disposeBag)
        viewModel.getPersonInfo()
    }
    
}
