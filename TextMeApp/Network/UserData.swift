//
//  UserData.swift
//  TextMeApp
//
//  Created by jane on 10.05.2022.
//

import Foundation
import UIKit
import RealmSwift

class UserData {
    
    func loadData(completion: @escaping ([User]) -> Void) {

    var urlConstructor = URLComponents()
            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
    urlConstructor.path = "/method/friends.get"
            urlConstructor.queryItems = [
                URLQueryItem(name: "access_token", value: String(Session.instance.token)),
                URLQueryItem(name: "v", value: "5.131"),
                URLQueryItem(name: "user_id", value: String(Session.instance.userID)),
                URLQueryItem(name: "fields", value: "photo_100")
            ]
        guard let url = urlConstructor.url else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard
                let data = data,
                let model = try? JSONDecoder().decode(UserResponse.self, from: data) else {return}
                let items = model.response.items
                
                let users: [User] = items.map { item in
                    let user = User(id: item.id,
                                    firstName: item.firstName,
                                    lastName: item.lastName,
                                    avatar: item.avatar)
                    return user
                }
            completion(users)
            self.save(users: users)
        }.resume()
    }
    
    
     func save(users: [User]) {
         
         let realmUsers: [RealmUser] = users.map { user in
         let realmUser = RealmUser()
         realmUser.id = user.id
         realmUser.firstName = user.firstName
         realmUser.lastName = user.lastName
         realmUser.avatar = user.avatar
             
             return realmUser
         }
        do {
            let realm = try Realm()
            try realm.write {
                realmUsers.forEach { realm.add($0) }
            }
        } catch {
            print(error)
        }
    }
    
    func restore() throws -> [User] {
        let realm = try Realm()
        let objects = realm.objects(RealmUser.self)
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
}
