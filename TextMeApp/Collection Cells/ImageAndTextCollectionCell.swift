//
//  ImageAndTextColectionCell.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 01.06.2022.
//

import Foundation
import UIKit

class ImageAndTextCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = String(describing: ImageAndTextCollectionCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: ImageAndTextCollectionCell.self), bundle: nil)
    }
    
    func configure(with model: Attachments) {
        
        if let url = URL(string: model.photo?.sizes?.first?.url ?? "" ) {
            imageView.load(url: url)
        }
    }
}


