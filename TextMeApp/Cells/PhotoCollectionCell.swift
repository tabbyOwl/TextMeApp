//
//  PhotoCollectionCell.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//

import UIKit

class PhotoCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var photoCellImageView: UIImageView!


func configure(with model: Photo) {
   
    if let url = URL(string: model.sizes.last?.url ?? "") {
        photoCellImageView.load(url: url)
    }
}
}
