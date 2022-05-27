//
//  GroupSearchingData.swift
//  TextMeApp
//
//  Created by jane on 12.05.2022.
//

import Foundation
import UIKit
import RealmSwift

class GroupSearchApi {
    
    func loadData(searchText: String, completion: @escaping ([Group]) -> Void)  {

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
                let items = model.response.items
                for item in items {
                    let id = item.id
                    let name = item.name
                    let isSuscribe = item.isSuscribe
                    let avatar = item.avatar
                    groups.append(Group(id: id, name: name, avatar: avatar, isSuscribe: isSuscribe))
                }
                    completion(groups)
            } catch {
                print(error)
            }
        }.resume()
    }
}



