//
//  UserData.swift
//  TextMeApp
//
//  Created by jane on 10.05.2022.
//

import Foundation
import UIKit

private struct UserResponse: Decodable {
    let response: Response
}

private struct Response : Decodable {
    //let count: Int
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
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
                
            do {
                let model = try JSONDecoder().decode(UserResponse.self, from: data)
                
                var users: [User] = []
                let items = model.response.items
                
                for item in items {
                    let id = item.id
                    let name = "\(item.firstName) \(item.lastName)"
                    let avatar = Photo(id: item.id, url: item.avatar)
                    users.append(User(id: id, name: name, avatar: avatar))
                }
                    completion(users)
            } catch {
                print(error)
            }
        }.resume()
    }
}
