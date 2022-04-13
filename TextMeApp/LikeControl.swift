//
//  LikeControl.swift
//  TextMeApp
//
//  Created by jane on 07.04.2022.
//

import UIKit

class LikeControl: UIControl {

    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var likesCounter: Int = 0
    
    override var isSelected: Bool {
        didSet {
            imageView.image = isSelected ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            
            if isSelected {
                likesCounter += 1
                
            } else {
                likesCounter -= 1
            }
            
            if likesCounter != 0 {
            likeLabel.text = "\(likesCounter)"
            } else {
                likeLabel.text = ""
                }
        }
    }
}