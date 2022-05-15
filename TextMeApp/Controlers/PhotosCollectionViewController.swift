//
//  PhotosViewController.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    var userIndex: Int = 0

    var photos: [Photo] {
        allUsers[userIndex].photos
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        PhotoData().loadData(userId: allUsers[userIndex].id) { [weak self] (complition) in
            DispatchQueue.main.async {
            //self?.user.photos = complition
                allUsers[self!.userIndex].photos = complition
            self?.collectionView.reloadData()
            
            }
        }
}
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionCell
        cell?.configure(with: photos[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? PhotoCollectionCell,
              let index = collectionView.indexPath(for: cell)?.item,
              let onePhotoVC = segue.destination as? PhotoViewController else {
                  return
              }
        onePhotoVC.userIndex = self.userIndex
        let currentPhoto = photos[index]
        onePhotoVC.indexOfCurrentImage = photos.firstIndex(where: { $0.id == currentPhoto.id } ) ?? 0
    }
}

