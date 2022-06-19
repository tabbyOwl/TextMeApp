//
//  ImageAndTextCell.swift
//  TextMeApp
//
//  Created by jane on 13.05.2022.
//

import Foundation
import UIKit

class ImageAndTextTableCell: UITableViewCell {
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var newsLabel: UILabel?
    
    //MARK: - Public properties
    
    var images: [Attachments] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLayout()
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
      
    }
    
    func setupLayout() {
        let layout = UICollectionViewFlowLayout()

        //Spacing between cells
        layout.itemSize = CGSize(width: (imageCollectionView.frame.size.width/3)-3, height: (imageCollectionView.frame.size.width/3)-3)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        //Spacing Between the edges of the screen
        layout.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        
        imageCollectionView.collectionViewLayout = layout
        
        imageCollectionView.register(ImageAndTextCollectionCell.nib(), forCellWithReuseIdentifier: ImageAndTextCollectionCell.identifier)
       
    }
}

extension ImageAndTextTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
         
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageAndTextCollectionCell.identifier, for: indexPath)
        
         let image = images[indexPath.item]
         (cell as? ImageAndTextCollectionCell)?.configure(with: image)
         
        return cell
    }
}

extension ImageAndTextTableCell: NewsCellProtocol {
    func set<T: NewsCellDataProtocol>(value: T) {

        self.images = value.attachments ?? []
        
        newsLabel?.text = value.text
    }

}

