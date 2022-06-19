//
//  RealmData.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 12.06.2022.
//

import RealmSwift

class RealmData {
    
    func save<T: Object>(objects: [T]) {
        do {
            let realm = try Realm()
            try realm.write {
                objects.forEach { realm.add($0, update: .modified) }
            }
        } catch {
            print(error)
        }
    }
    
    func restore<T: Object>(_ object: T.Type) throws -> Results<T> {
        
        let realm = try Realm()
        return realm.objects(object)
        
    }
    
    func restore<T: Object>(_ object: T.Type) throws -> [T] {
        
        let realm = try Realm()
        return Array(realm.objects(object))
        
    }
    
    func delete<T: Object>(_ object: T) {
        
        do {
            let realm = try Realm()
                try realm.write {
                    realm.delete(object)
                }
            
        } catch {
            print(error)
        }
    }
    
    //MARK: -photos methods
    func save(photos: [Photo]) {
        
        photos.forEach { photo in
            photo.likesCount = photo.likes?.likesCount ?? 0
            photo.isLiked = photo.likes?.isLiked ?? false
            photo.url = photo.sizes.last?.url ?? ""
            
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(photo, update: .modified)
                }
                
            } catch {
                print(error)
            }
        }
    }
    
    func updateLikes(photo: Photo, likesCount: Int) {
        do {
            let realm = try Realm()
            try realm.write {
                photo.isLiked = !photo.isLiked
                photo.likesCount = likesCount
            }
        }
        catch {
            print(error)
        }
    }
    
 
    
    func restorePhotosById(userId: Int) throws -> [Photo] {
        let realm = try Realm()
       return realm.objects(Photo.self).filter({$0.ownerId == userId})
        
    }
        
    //MARK: -group methods
    func deleteGroup(group: Group) {
        
        do {
            let realm = try Realm()
            guard let realmGroup = realm.object(ofType: Group.self, forPrimaryKey: group.id) else { return }
                try realm.write {
                    realm.delete(realmGroup)
                }
            
        } catch {
            print(error)
        }
    }

}
