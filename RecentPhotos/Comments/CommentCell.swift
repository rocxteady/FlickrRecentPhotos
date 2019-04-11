//
//  CommentCell.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import UIKit
import Kingfisher

class CommentCell: UITableViewCell {
    
    static let identifier = "CommentCell"

    @IBOutlet private weak var ownerNameLabel: UILabel!
    @IBOutlet private weak var ownerPhotoImageView: UIImageView!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var createdDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ownerPhotoImageView.layer.cornerRadius = self.ownerPhotoImageView.bounds.width/2.0
        self.ownerPhotoImageView.layer.masksToBounds = true
    }

    func load(comment: FlickrComment) {
        self.commentLabel.text = comment.content
        self.ownerNameLabel.text = comment.authorName
        self.createdDateLabel.text = comment.dateCreate
        if let photoURLString = comment.photoURL {
            self.ownerPhotoImageView.kf.setImage(with: URL(string: photoURLString), placeholder: UIImage(named: "profile"))
        }
        else {
            self.ownerPhotoImageView.image = UIImage(named: "profile")
        }
    }
    
}
