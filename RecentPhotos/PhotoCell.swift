//
//  PhotoCell.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    static let identifier = "PhotoCell"

    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerPhotoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!

}
