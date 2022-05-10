//
//  NewsTableViewCell.swift
//  TextMeApp
//
//  Created by jane on 12.04.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var likeControl: LikeControl!
    
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    
    var photoDidLiked: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeControl.imageView = likeImage
        likeControl.likeLabel = likeLabel
        
        likeControl.addTarget(self, action: #selector(likeControlTapped), for: .touchUpInside)
        
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @objc func likeControlTapped() {
    
         likeControl.isSelected = !likeControl.isSelected
        photoDidLiked?(likeControl.isSelected)
        
     }
}
