//
//  PhotosViewController.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class PhotosCollectionViewController: UICollectionViewController {
    
    var photos: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionCell
        let photo = photos[indexPath.item]
        cell?.photoCellImageView.image = photo
        
        return cell ?? UICollectionViewCell()
    }
    
    // MARK: не работает
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? PhotoCollectionCell,
              let index = collectionView.indexPath(for: cell)?.item,
              let OnePhotoVC = segue.destination as? OnePhotoViewController else {
                  return
              }
        let photo = photos[index]
        OnePhotoVC.onePhotoImageView.image = photo

    }
    
}
