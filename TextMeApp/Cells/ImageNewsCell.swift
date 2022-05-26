//
//  ImageNews.swift
//  TextMeApp
//
//  Created by jane on 13.05.2022.
//

import Foundation
import UIKit

class ImageNewsCell: UITableViewCell {
    
@IBOutlet weak var collectionView: UICollectionView!
    
    weak var cellDelegate: CollectionViewCellDelegate?
    
    var images: [URL]?
    
}

extension ImageNewsCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ImageAndTextColectionCell
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images?.count ?? 0
    }
    
    private func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? ImageCollectionCell {
            cell.imageView.load(url: (images?[indexPath.item])!)
            print("🐹🐹🐹🐹🐹🐹🐹🐹🐹🐹🐹🐹🐹🐹🐹🐹\(images)")
            return cell
        }
        return UICollectionViewCell()
    }
}
    
extension ImageNewsCell: NewsCellProtocol {
    func set<T: NewsCellDataProtocol>(value: T) {
        images = value.imageUrls
        self.collectionView.reloadData()
    }
}
