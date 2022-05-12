//
//  PhotoData.swift
//  TextMeApp
//
//  Created by jane on 10.05.2022.
//

import Foundation

private struct PhotoResponse: Decodable {
    let response: Response
}

private struct Response : Decodable {
    let count: Int
    let items: [Items]
}

private struct Items: Decodable {
    let id: Int
    let sizes: [Sizes]
    let likes: Likes
    
    enum CodingKeys: String, CodingKey {
        case id
        case sizes
        case likes
        }
    }

private struct Sizes: Decodable {
    let url: String
   
}

private struct Likes: Decodable {
    let user_likes: Int
    let count: Int
}

class PhotoData {
    
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
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
                
            do {
                let model = try JSONDecoder().decode(PhotoResponse.self, from: data)
                
                var photos: [Photo] = []
                
                for i in 0...model.response.items.count-1 {
                    let id = model.response.items[i].id
                    var isLiked = false
                    if model.response.items[i].likes.user_likes != 0 {
                        isLiked = true
                    }
                    let likesCount = model.response.items[i].likes.count
                    if let url = model.response.items[i].sizes.last?.url {
                        photos.append(Photo(id: id, url: url, likesCounter: likesCount, isLiked: isLiked))
                    }
                }
                    completion(photos)
            } catch {
                print(error)
            }
        }.resume()
    }
}
