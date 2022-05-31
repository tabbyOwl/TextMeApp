//
//  PhotosViewController.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//

import UIKit
import RealmSwift

class PhotosCollectionViewController: UICollectionViewController {
    
    //MARK: - Public properties
    
    var userId: Int = 0
    
    //MARK: - Private properties
    private var photos: [Photo] = []
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let restoredPhotos: [Photo] = try RealmData().restore()
            if restoredPhotos.isEmpty || !restoredPhotos.contains(where: { $0.ownerId == userId }) {
                    PhotoApi().loadData(userId: self.userId) { [weak self] (completion) in
                        DispatchQueue.main.async {
                    self?.photos = completion
                    self?.collectionView.reloadData()
                }
            }
            } else {
                photos = restoredPhotos.filter { $0.ownerId == userId }
            }
        } catch {
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
        onePhotoVC.photos = self.photos
        let currentPhoto = photos[index]
        onePhotoVC.indexOfCurrentImage = photos.firstIndex(where: { $0.id == currentPhoto.id } ) ?? 0
    }
}

