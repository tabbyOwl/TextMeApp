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
    
 
    var images: [URL] = []
    
}

extension ImageNewsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? ImageCollectionCell {
            cell.imageView.load(url: (images[indexPath.item]))
            return cell
        }
        return UICollectionViewCell()
    }
}
    
extension ImageNewsCell: NewsCellProtocol {
    func set<T: NewsCellDataProtocol>(value: T) {
       // self.images = value.imageUrls ?? []
    }
}
