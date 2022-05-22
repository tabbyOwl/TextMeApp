//
//  ImageNews.swift
//  TextMeApp
//
//  Created by jane on 13.05.2022.
//

import Foundation
import UIKit

class ImageNewsCell: UITableViewCell {
    
@IBOutlet weak var imageCollectionView: UICollectionView!
    
    weak var cellDelegate: CollectionViewCellDelegate?
    
    var images: [URL]?
    
    override func awakeFromNib() {
        
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.delegate = self
    }
}

extension ImageNewsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func updateCellWith(images: [URL]?) {
        self.images = images
        self.imageCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ImageAndTextColectionCell
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageNewsCell", for: indexPath) as? ImageCollectionCell {
            cell.newsImageView.load(url: (images?[indexPath.item])!)
            return cell
        }
        return UICollectionViewCell()
    }
}
    
extension ImageNewsCell: NewsCellProtocol {
    func set<T: NewsCellDataProtocol>(value: T) {
        print("IMAGENEWSCELL🌹")
        self.images = value.imageUrls
        self.imageCollectionView.reloadData()
    }
}
