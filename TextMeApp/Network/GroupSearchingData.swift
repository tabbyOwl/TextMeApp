//
//  GroupSearchingData.swift
//  TextMeApp
//
//  Created by jane on 12.05.2022.
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

class GroupSearchingData {
    
    func loadData(searchText: String, completion: @escaping ([Group]) -> Void) {

    var urlConstructor = URLComponents()
            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
    urlConstructor.path = "/method/groups.search"
            urlConstructor.queryItems = [
                URLQueryItem(name: "access_token", value: String(Session.instance.token)),
                URLQueryItem(name: "v", value: "5.131"),
                URLQueryItem(name: "user_id", value: String(Session.instance.userID)),
                URLQueryItem(name: "q", value: searchText)
            ]
        guard let url = urlConstructor.url else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
                
            do {
                let model = try JSONDecoder().decode(GroupResponse.self, from: data)

                var groups: [Group] = []
                
                for i in 0...model.response.items.count-1 {
                    let name = model.response.items[i].name
                    let avatar = Photo(id: model.response.items[i].id, url: model.response.items[i].avatar)
                    groups.append(Group(name: name, avatar: avatar))
                }
                    completion(groups)
            } catch {
                print(error)
            }
        }.resume()
    }
}

