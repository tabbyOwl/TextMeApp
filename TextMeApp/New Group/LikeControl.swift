//
//  LikeControl.swift
//  TextMeApp
//
//  Created by jane on 07.04.2022.
//

import UIKit

class LikeControl: UIControl {

    weak var likeLabel: UILabel?
    weak var imageView: UIImageView?
    
    var likesCounter: Int = 0
    
    override var isSelected: Bool {
        didSet {
            
            guard oldValue != isSelected else { return }
            
            self.imageView?.image = isSelected ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { [self] in
                imageView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: {_ in
                UIView.animate(withDuration: 0.5, animations: {
                    self.imageView?.transform = CGAffineTransform.identity
                })
            })

            if isSelected {
                likesCounter += 1
                
            } else {
                likesCounter -= 1
            }
            
            if likesCounter != 0 {
                UIView.transition(with: self.likeLabel ?? UILabel(), duration: 0.5, options: [.transitionCrossDissolve], animations: {
                    self.likeLabel?.text = "\(self.likesCounter)"
                }, completion: nil)
            } else {
                likeLabel?.text = ""
                }
        }
    }
}
