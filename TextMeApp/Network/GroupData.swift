//
//  GroupData.swift
//  TextMeApp
//
//  Created by jane on 10.05.2022.
//

import Foundation
import UIKit
import RealmSwift

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

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard
                let data = data,
                let model = try? JSONDecoder().decode(GroupResponse.self, from: data) else {return}
                let items = model.response.items
                
                let groups: [Group] = items.map { item in
                    let group = Group(id: item.id,
                                      name: item.name,
                                      avatar: item.avatar,
                                      isSuscribe: item.isSuscribe)
                    
                    return group
                }
            completion(groups)
            self.save(groups: groups)
        }.resume()
    }
    
    func delete(realmGroup: RealmGroup) {
        
        do {
        let realm = try Realm()
        try realm.write {
            realm.delete(realmGroup)
            }
        } catch {
            print(error)
        }
    }
    
    
     func save(groups: [Group]) {
         
         let realmGroups: [RealmGroup] = groups.map { group in
             let realmGroup = RealmGroup()
             realmGroup.id = group.id
             realmGroup.name = group.name
             realmGroup.avatar = group.avatar
             realmGroup.isSuscribe = group.isSuscribe
             
             return realmGroup
         }
        do {
            let realm = try Realm()
            try realm.write {
                realmGroups.forEach { realm.add($0) }
            }
        } catch {
            print(error)
        }
    }
    
    func restore() throws -> [Group] {
        let realm = try Realm()
        
        let objects = realm.objects(RealmGroup.self)
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
}

