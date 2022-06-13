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
    private var service = PhotoService()
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      fetchPhotos()
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
        
        onePhotoVC.indexOfCurrentImage = photos.firstIndex(where:{ $0.id == currentPhoto.id}) ?? 0
    }
    
    //MARK: Private methods
    
    private func fetchPhotos() {
        do {
            let realm = try Realm()
            let restoredPhotos = realm.objects(PhotoRealm.self)
            if restoredPhotos.isEmpty {
                PhotoService().loadPhotos(userId: self.userId) { result in
                    switch result {
                    case .success(let photo):
                        DispatchQueue.main.async {
                            RealmData().save(objects: photo)
                        }
                    case .failure(_):
                        return
                    }
                }
                self.photos = try RealmData().restore()
                self.collectionView.reloadData()
            } else {
                self.photos = try RealmData().restore()
                self.collectionView.reloadData()
            }
            
        } catch {
            print(error)
        }
    }
}
