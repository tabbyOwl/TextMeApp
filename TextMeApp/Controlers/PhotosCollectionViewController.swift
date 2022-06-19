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
    private var realmData = RealmData()
    private var token: NotificationToken?
    
    var photos: [Photo]? {
        
        try? realmData.restorePhotosById(userId: userId)
    }
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPhotos()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionCell
        if let photo = photos?[indexPath.row] {
        cell?.configure(with: photo)
        }
        return cell ?? UICollectionViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? PhotoCollectionCell,
              let index = collectionView.indexPath(for: cell)?.item,
              let onePhotoVC = segue.destination as? PhotoViewController else {return}
        onePhotoVC.photos = self.photos ?? []
        if let currentPhoto = photos?[index] {
            
            onePhotoVC.indexOfCurrentImage = photos?.firstIndex(where: { $0.id == currentPhoto.id}) ?? 0
        }
    }

    //MARK: Private methods
    
    private func fetchPhotos() {
        
        PhotoService().loadPhotos(userId: userId) { result in
            switch result {
            case .success(let photoResult):
                DispatchQueue.main.async {
                    RealmData().save(photos: photoResult)
                  
                }
            case .failure(_):
                return
            }
        }
    }
}
    


