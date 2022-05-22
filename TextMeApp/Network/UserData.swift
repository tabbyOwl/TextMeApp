//
//  UserData.swift
//  TextMeApp
//
//  Created by jane on 10.05.2022.
//

import Foundation
import UIKit
import Realm
import RealmSwift

private struct UserResponse: Decodable {
    let response: Response
}

private struct Response : Decodable {
    let items: [Items]
}

private struct Items: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_100"
        }
    }

class UserData {
    
    func loadData() {

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
                
                let realmUsers: [RealmUser] = items.map { user in
                    let realmUser = RealmUser()
                    realmUser.id = user.id
                    realmUser.firstName = user.firstName
                    realmUser.lastName = user.lastName
                    realmUser.avatar = user.avatar
                    
                    return realmUser
                }
            self.save(users: realmUsers)
        }.resume()
    }
    
    
    private func save(users: [RealmUser]) {
        do {
            let realm = try Realm()
            try realm.write {
                users.forEach { realm.add($0) }
                
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
                     name: $0.firstName + $0.lastName,
                      avatar: Photo(id:  $0.id, url: $0.avatar)
                )
            })
        return users
    }
}
