//
//  OneImageViewController.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//

import UIKit

class OnePhotoViewController: UIViewController {
    
    @IBOutlet weak var onePhotoImageView: UIImageView!
    
    var photo: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onePhotoImageView.image = photo
    }
}
