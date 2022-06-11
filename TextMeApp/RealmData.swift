////
////  RealmData.swift
////  
////
////  Created by Svetlana Oleinikova on 01.06.2022.
////
//
//import Foundation
//import RealmSwift
//
//class RealmData {
//
//     func delete(group: Group) {
//
//         do {
//         let realm = try Realm()
//         let objects = realm.objects(RealmGroup.self).filter{ $0.id == group.id }
//             if let realmGroup = objects.first {
//                 try realm.write {
//                     realm.delete(realmGroup)
//                 }
//             }
//         } catch {
//             print(error)
//         }
//     }
//
//     func save(group: Group) {
//
//         let realmGroup = RealmGroup()
//         realmGroup.id = group.id
//         realmGroup.name = group.name
//         realmGroup.avatar = group.avatar
//         realmGroup.isSuscribe = group.isSuscribe
//         do {
//             let realm = try Realm()
//             try realm.write {
//                 realm.add(realmGroup)
//             }
//         } catch {
//             print(error)
//         }
//     }
//
//     func save(users: [User]) {
//
//         let realmUsers: [RealmUser] = users.map { user in
//         let realmUser = RealmUser()
//         realmUser.id = user.id
//         realmUser.firstName = user.firstName
//         realmUser.lastName = user.lastName
//         realmUser.avatar = user.avatar
//
//             return realmUser
//         }
//        do {
//            let realm = try Realm()
//            try realm.write {
//                realmUsers.forEach { realm.add($0) }
//            }
//        } catch {
//            print(error)
//        }
//    }
//
//     func save(photos: [Photo]) {
//
//         let realmPhotos: [RealmPhoto] = photos.map { photo in
//         let realmPhoto = RealmPhoto()
//         realmPhoto.id = photo.id
//         realmPhoto.url = photo.urls.last?.url ?? ""
//         realmPhoto.likes = photo.likes.count
//         realmPhoto.isLiked = photo.likes.user_likes
//         realmPhoto.ownerId = photo.ownerId
//
//             return realmPhoto
//         }
//        do {
//            let realm = try Realm()
//            try realm.write {
//                realmPhotos.forEach { realm.add($0) }
//            }
//        } catch {
//            print(error)
//        }
//    }
//
//      func restore() throws -> [User] {
//         let realm = try Realm()
//         let objects = realm.objects(RealmUser.self)
//         let users = Array(
//             objects.map {
//                 User(id: $0.id,
//                      firstName: $0.firstName,
//                      lastName: $0.lastName,
//                      avatar: $0.avatar)
//             }
//         )
//         return users
//     }
//
//      func restore() throws -> [Group] {
//         let realm = try Realm()
//
//         let objects = realm.objects(RealmGroup.self)
//         let groups = Array(
//             objects.map {
//                 Group(id: $0.id,
//                      name: $0.name,
//                      avatar: $0.avatar,
//                       isSuscribe: $0.isSuscribe)
//             }
//         )
//         return groups
//     }
//    
//     func restore() throws -> [Photo] {
//
//         let realm = try Realm()
//         let objects = realm.objects(RealmPhoto.self)
//         let photos = Array(
//             objects.map {
//                 Photo(id: $0.id,
//                       urls: [PhotoUrl(url: $0.url)],
//                       likes: Likes(user_likes: $0.isLiked, count: $0.likes),
//                       ownerId: $0.ownerId)
//             }
//         )
//         return photos
//     }
//}
