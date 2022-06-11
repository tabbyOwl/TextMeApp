//
//  ImageAndTextCell.swift
//  TextMeApp
//
//  Created by jane on 13.05.2022.
//

import Foundation
import UIKit

class ImageAndTextCell: UITableViewCell {
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var newsLabel: UILabel?
    
    //MARK: - Public properties
    
    var images: [PhotoUrl] = []
    
//    func updateCellWith(urls: [URL]) {
//        self.images = urls
//        self.imageCollectionView.reloadData()
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.reloadData()
        
    }
}

extension ImageAndTextCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
         
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsImageCell", for: indexPath)
        
        
         (cell as? ImageAndTextColectionCell)?.configure(with: images[indexPath.item])
         
        return cell
    }
}

extension ImageAndTextCell: NewsCellProtocol {
    func set<T: NewsCellDataProtocol>(value: T) {
        
//        updateCellWith(urls: value.imageUrls ?? [])
        self.images = value.attachments?.last?.photo?.urls ?? []
        
        newsLabel?.text = value.text
    }

}

