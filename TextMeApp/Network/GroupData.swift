//
//  GroupData.swift
//  TextMeApp
//
//  Created by jane on 10.05.2022.
//

import Foundation
import UIKit

private struct GroupResponse : Decodable {
    let response: Response
}

private struct Response : Decodable {
    let count: Int
    let items: [Items]
}

private struct Items: Decodable {
    let id: Int
    let name: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_50"
    }
}

class GroupData {

    func loadData(completion: @escaping ([Group]) -> Void) {

    var urlConstructor = URLComponents()
            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
    urlConstructor.path = "/method/groups.get"
            urlConstructor.queryItems = [
                URLQueryItem(name: "access_token", value: String(Session.instance.token)),
                URLQueryItem(name: "v", value: "5.131"),
                URLQueryItem(name: "user_id", value: String(Session.instance.userID)),
                URLQueryItem(name: "extended", value: "1")
            ]
        guard let url = urlConstructor.url else {return}

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}

            do {
                let model = try JSONDecoder().decode(GroupResponse.self, from: data)

                var groups: [Group] = []
                
                let items = model.response.items
                for item in items {
                    let name = item.name
                    let avatar = Photo(id: item.id, url: item.avatar)
                    groups.append(Group(name: name, avatar: avatar))
                }
                    completion(groups)
            } catch {
                print(error)
            }
        }.resume()
    }
}
