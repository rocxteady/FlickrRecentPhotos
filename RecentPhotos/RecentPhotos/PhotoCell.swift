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
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var photoButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoButtonWidthConstraint: NSLayoutConstraint!
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
            self.photoButtonHeightConstraint.constant = height
            self.photoButtonWidthConstraint.constant = width
        }
        else {
            self.photoButtonHeightConstraint.constant = 85.0
            self.photoButtonWidthConstraint.constant = 85.0
        }
        if let photoURLString = photo.urlS {
            self.photoButton.kf.setImage(with: URL(string: photoURLString), for: .normal, placeholder: UIImage(named: "image"))
        }
        else {
            self.photoButton.setImage(UIImage(named: "image"), for: .normal)
        }
    }
    
}
