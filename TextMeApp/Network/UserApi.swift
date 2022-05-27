//
//  UserData.swift
//  TextMeApp
//
//  Created by jane on 10.05.2022.
//

import Foundation
import UIKit
import RealmSwift

class UserApi {
    
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
            RealmData().save(users: users)
        }.resume()
    }
}
