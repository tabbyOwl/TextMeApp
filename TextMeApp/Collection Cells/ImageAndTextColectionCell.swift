//
//  ImageAndTextColectionCell.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 01.06.2022.
//

import Foundation
import UIKit

class ImageAndTextColectionCell: UICollectionViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    
    func configure(with model: Sizes) {
        print(model.url)
        if let url = URL(string: model.url ) {
            newsImageView.load(url: url)
        }
    }
}


