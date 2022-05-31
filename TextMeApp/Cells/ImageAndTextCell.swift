////
////  ImageAndTextCell.swift
////  TextMeApp
////
////  Created by jane on 13.05.2022.
////
//
//import Foundation
//import UIKit
//
//protocol CollectionViewCellDelegate: AnyObject {
//    func collectionView(collectionviewcell: ImageAndTextColectionCell?, index: Int, didTappedInTableViewCell: UITableViewCell)
//    // other delegate methods that you can define to perform action in viewcontroller
//}
//
//class ImageAndTextCell: UITableViewCell {
//    
//    @IBOutlet weak var imageCollectionView: UICollectionView!
//    
//    @IBOutlet weak var newsLabel: UILabel?
//    
//    weak var cellDelegate: CollectionViewCellDelegate?
//    
//    var images: [URL]?
//    
//}
//
//extension ImageAndTextCell: UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as? ImageAndTextColectionCell
//        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.images?.count ?? 0
//    }
//    
//    private func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsImageCell", for: indexPath) as? ImageAndTextColectionCell {
//            cell.newsImageView.load(url: (images?[indexPath.item])!)
//            return cell
//        }
//        return UICollectionViewCell()
//    }
//}
//
//extension ImageAndTextCell: NewsCellProtocol {
//    func set<T: NewsCellDataProtocol>(value: T) {
//        self.images = value.imageUrls!
//        newsLabel?.text = value.text
//        self.imageCollectionView.reloadData()
//    }
//
//}
