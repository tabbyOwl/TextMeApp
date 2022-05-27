//
//  PhotoData.swift
//  TextMeApp
//
//  Created by jane on 10.05.2022.
//

import Foundation
import RealmSwift


class PhotoApi {
    
    func loadData(userId: Int, completion: @escaping ([Photo]) -> Void) {

    var urlConstructor = URLComponents()
            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
    urlConstructor.path = "/method/photos.getAll"
            urlConstructor.queryItems = [
                URLQueryItem(name: "access_token", value: String(Session.instance.token)),
                URLQueryItem(name: "v", value: "5.131"),
                URLQueryItem(name: "user_id", value: String(Session.instance.userID)),
                URLQueryItem(name: "count", value: "200"),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "owner_id", value: String(userId))
            ]
        guard let url = urlConstructor.url else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard
                let data = data,
                let model = try? JSONDecoder().decode(PhotoResponse.self, from: data) else {return}
                let items = model.response.items
                
            let photos: [Photo] = items.map { item in
                
                let photo = Photo(id: item.id,
                                  sizes: [PhotoUrl(url: item.sizes.last?.url ?? "")],
                                  likes: Likes(user_likes: item.likes.user_likes,count: item.likes.count),
                                  ownerId: item.ownerId)
                return photo
                }
                completion(photos)
            RealmData().save(photos: photos)
        }.resume()
    }

}

