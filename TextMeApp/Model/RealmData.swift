//
//  RealmData.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 12.06.2022.
//

import RealmSwift

class RealmData {
    
    func save(user: User) {
        
        let realmUser = RealmUser()
        realmUser.id = user.id
        realmUser.firstName = user.firstName
        realmUser.lastName = user.lastName
        realmUser.avatar = user.avatar
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(realmUser)
            }
        } catch {
            print(error)
        }
    }
    
    func save(photo: Photo, userId: Int) {
        
        let realmPhoto = RealmPhoto()
        realmPhoto.id = photo.id
        realmPhoto.url = photo.url
        realmPhoto.likesCount = photo.likes?.likesCount ?? 0
        realmPhoto.isLiked = photo.likes?.isLiked ?? false
        
        do {
            let realm = try Realm()
            let realmUser = realm.object(ofType: RealmUser.self, forPrimaryKey: userId)
            try realm.write {
                realm.add(realmPhoto)
                realmUser?.photos.append(realmPhoto)
                realmPhoto.ownerId = realmUser?.id ?? 0
            }
        } catch {
            print(error)
        }
    }
    
    func restore(userId: Int) throws -> [Photo] {
        let realm = try Realm()
        //let realmUser = realm.object(ofType: RealmUser.self, forPrimaryKey: userId)
        let realmPhotos = realm.objects(RealmPhoto.self).filter({$0.ownerId == userId})
        let photos: [Photo] = realmPhotos.map({
            let photo = Photo(id: $0.id,
                              sizes: [Sizes(url: $0.url)],
                            likes: Likes(userLikes: $0.isLiked ? 1:0, likesCount: $0.likesCount),
                            ownerId: $0.ownerId)

            return photo
        })
        
        return photos
    }
    
    func restore() throws -> [User] {
        let realm = try Realm()
        
        let realmUsers = realm.objects(RealmUser.self)
        let users: [User] = realmUsers.map({
            let user = User(id: $0.id,
                            firstName: $0.firstName,
                            lastName: $0.lastName,
                            avatar: $0.avatar)
            return user
        })
        
        return users
    }
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
    

    
//    func save(photos: [Photos], user: User) {
//        do {
//            let realm = try Realm()
//            try realm.write {
//                photos.forEach { realm.add($0, update: .modified) }
//                photos.forEach { $0.user = user}
//                photos.forEach{
//                    user.photos.append($0)
//            }
//            }
//        } catch {
//            print(error)
//        }
//    }
}


