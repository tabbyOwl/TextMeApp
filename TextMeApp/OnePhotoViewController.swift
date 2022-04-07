//
//  OneImageViewController.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//

import UIKit

class OnePhotoViewController: UIViewController {
    
    @IBOutlet weak var onePhotoImageView: UIImageView!
    
    @IBOutlet weak var likeControl: LikeControl!
    
    var photo: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onePhotoImageView.image = photo
        print(1)
        likeControl.addTarget(self, action: #selector(likeControlTapped), for: .touchUpInside)
        print(2)
        
    }
  
    @objc func likeControlTapped() {
        likeControl.isSelected = !likeControl.isSelected
    }
    
}
