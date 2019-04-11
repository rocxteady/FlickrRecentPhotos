//
//  PhotoViewController.swift
//  RecentPhotos
//
//  Created by Ulaş Sancak on 8.04.2019.
//  Copyright © 2019 Ulaş Sancak. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoViewController: UIViewController {

    //Private properties
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var closeButton: UIButton!
    
    private var shouldStatusBarBeHidden = false
    
    //Public properties
    var photoURLString: String!
    
    override var prefersStatusBarHidden: Bool {
        return self.shouldStatusBarBeHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 10.0
        if let photoURL = URL(string: photoURLString) {
            self.photoImageView.kf.setImage(with: photoURL, placeholder: UIImage(named: "image"))
        }
        else {
            self.photoImageView.image = UIImage(named: "image")
        }
        self.photoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageViewTap)))
    }
    
    @objc private func handleImageViewTap() {
        self.shouldStatusBarBeHidden = !self.shouldStatusBarBeHidden
        UIView.animate(withDuration: 0.25) {
            self.closeButton.alpha = self.shouldStatusBarBeHidden ? 0 : 1.0
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    @IBAction private func dismiss(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

//MARK: UIScrollView Delegate
extension PhotoViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoImageView
    }
    
}
