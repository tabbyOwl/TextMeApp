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
    
    func save(photos: [Photo], userId: Int) {
        do {
            let realm = try Realm()
            let user = realm.object(ofType: User.self, forPrimaryKey: userId)
            try realm.write {
                photos.forEach {
                   
                    realm.add($0, update: .modified)
                    user?.photos.append($0)
                }
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
    
    func restore(userId: Int) throws -> [Photo] {
        let realm = try Realm()
       return realm.objects(Photo.self).filter({$0.ownerId == userId})
        
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
}


