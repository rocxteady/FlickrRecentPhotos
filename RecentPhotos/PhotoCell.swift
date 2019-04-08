//
//  PhotoCell.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class PhotoCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    var viewModel: PersonInfoViewModel!
    
    static let identifier = "PhotoCell"

    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerPhotoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ownerPhotoImageView.layer.cornerRadius = self.ownerPhotoImageView.bounds.width/2.0
        self.ownerPhotoImageView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }

    func load(photo: FlickrPhoto) {
        self.ownerNameLabel.text = photo.ownername
        self.createdDateLabel.text = photo.dateTaken
        self.viewCountLabel.text = "Views: " + (photo.views ?? "")
        self.viewModel = PersonInfoViewModel(personID: photo.owner!)
        self.viewModel.image
        .asObservable()
            .subscribe(onNext: { [weak self] (image) in
                self?.ownerPhotoImageView.image = image
            })
        .disposed(by: self.disposeBag)
        viewModel.getPersonInfo()
        if let width = photo.widthS?.toCGFloat(), let height = photo.heightS?.toCGFloat() {
            self.photoImageViewHeightConstraint.constant = height
            self.photoImageViewWidthConstraint.constant = width
        }
        if let photoURLString = photo.urlS {
            self.photoImageView.kf.setImage(with: URL(string: photoURLString), placeholder: UIImage(named: "image"))
        }
        else {
            self.photoImageView.image = UIImage(named: "image")
        }
//        self.layoutIfNeeded()
    }
    
}
