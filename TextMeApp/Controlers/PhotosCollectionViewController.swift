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
    
    var user: User?

    //MARK: - Private properties
    
  
    var userId: Int {
        user?.id ?? 0
    }
    
    var photos: [Photo] = []
    
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
              let index = collectionView.indexPath(for: cell)?.item else {
            //  let onePhotoVC = segue.destination as? PhotoViewController else {
            return
        }
       // onePhotoVC.photos = self.photos
        let currentPhoto = photos[index]
        
        //onePhotoVC.indexOfCurrentImage = photos?.firstIndex(where:{ $0.id == currentPhoto.id}) ?? 0
    }
    
    //MARK: Private methods
    
    private func fetchPhotos() {
        
        do{
            let realm = try Realm()
            let realmUser = realm.object(ofType: RealmUser.self, forPrimaryKey: userId)
            print("🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀")
            if let photos = realmUser?.photos {
                if photos.isEmpty {
                PhotoService().loadPhotos(userId: user?.id ?? 0) { result in
                    switch result {
                    case .success(let photoResult):
                        DispatchQueue.main.async {
                            photoResult.forEach { photo in
                                RealmData().save(photo: photo, userId: self.userId)
                            }
                        }
                    case .failure(_):
                        return
                    }
                }
            }
            }
            photos = try RealmData().restore(userId: self.userId)
            self.collectionView.reloadData()
        } catch {
            print(error)
        }
    }
}

