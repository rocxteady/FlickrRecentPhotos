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
    
    static let identifier = "PhotoCell"

    @IBOutlet private weak var ownerNameLabel: UILabel!
    @IBOutlet private weak var ownerPhotoImageView: UIImageView!
    @IBOutlet private weak var photoTitleLabel: UILabel!
    @IBOutlet private weak var photoButton: UIButton!
    @IBOutlet private weak var photoButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var photoButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var viewCountLabel: UILabel!
    @IBOutlet private weak var createdDateLabel: UILabel!
    @IBOutlet private weak var commentsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ownerPhotoImageView.layer.cornerRadius = self.ownerPhotoImageView.bounds.width/2.0
        self.ownerPhotoImageView.layer.masksToBounds = true
    }

    func load(photo: FlickrPhoto) {
        self.photoTitleLabel.text = photo.title
        self.ownerNameLabel.text = photo.ownername
        self.createdDateLabel.text = photo.dateTaken
        self.viewCountLabel.text = "Views: " + (photo.views ?? "")
        if let photoURLString = photo.ownerPhotoURL {
            self.ownerPhotoImageView.kf.setImage(with: URL(string: photoURLString), placeholder: UIImage(named: "profile"))
        }
        else {
            self.ownerPhotoImageView.image = UIImage(named: "profile")
        }
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
