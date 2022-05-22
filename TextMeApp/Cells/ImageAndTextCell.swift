//
//  ImageAndTextCell.swift
//  TextMeApp
//
//  Created by jane on 13.05.2022.
//

import Foundation
import UIKit

protocol CollectionViewCellDelegate: AnyObject {
    func collectionView(collectionviewcell: ImageAndTextColectionCell?, index: Int, didTappedInTableViewCell: UITableViewCell)
    // other delegate methods that you can define to perform action in viewcontroller
}

class ImageAndTextCell: UITableViewCell {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var newsLabel: UILabel?
    
    var images: [URL]?
    
    override func awakeFromNib() {
        
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.delegate = self
        
    }
}

extension ImageAndTextCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageAndTextCell", for: indexPath) as? ImageAndTextColectionCell {
            cell.newsImageView.load(url: (images?[indexPath.item])!)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ImageAndTextCell: NewsCellProtocol {
    func set<T: NewsCellDataProtocol>(value: T) {
        print("IMAGETEXTNEWSCELL☂️\(value.imageUrls?.count)")
        self.images = value.imageUrls
        newsLabel?.text = value.text
        self.imageCollectionView.reloadData()
    }

}
