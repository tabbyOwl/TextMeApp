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
                objects.forEach { realm.add($0) }
            }
        } catch {
            print(error)
        }
    }
    
   
    func restore() throws -> [User] {
             let realm = try Realm()
             let objects = realm.objects(UserRealm.self)
             let users = Array(
                 objects.map {
                     User(id: $0.id,
                          firstName: $0.firstName,
                          lastName: $0.lastName,
                          avatar: $0.avatar)
                 }
             )
             return users
         }
    
    func restore() throws -> [Group] {
             let realm = try Realm()
             let objects = realm.objects(GroupRealm.self)
             let groups = Array(
                 objects.map {
                     Group(id: $0.id,
                           name: $0.name,
                           avatar: $0.avatar,
                           isSuscribe: $0.isSuscribe)
                 }
             )
             return groups
         }
    
    func restore() throws -> [Photo] {
             let realm = try Realm()
             let objects = realm.objects(PhotoRealm.self)
             let photos = Array(
                 objects.map {
                     Photo(id: $0.id,
                           url: $0.urls.last?.url ?? "",
                           likes: $0.likes.count,
                           ownerId: $0.ownerId,
                           isLiked: $0.likes.last?.isLiked ?? false)
                 }
             )
             return photos
         }
}
