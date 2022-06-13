//
//  PhotoCollectionCell.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//

import UIKit

class PhotoCollectionCell: UICollectionViewCell {
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var photoCellImageView: UIImageView!

    //MARK: - Public methods
func configure(with model: Photo) {
   
    if let url = URL(string: model.url) {
        photoCellImageView.load(url: url)
    }
}
}
