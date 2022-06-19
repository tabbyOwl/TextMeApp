//
//  UserService.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 03.06.2022.
//

import Foundation
import RealmSwift

final class UserService {

    typealias UserResult = Result<[User], Error>

    func loadFriends(completion: @escaping(UserResult) -> ()) {
    
        let params = [
            "v": "5.131",
            "user_id": String(Session.instance.userID),
            "fields": "photo_100"
        ]

        let url: URL = .configureURL(token: Session.instance.token, typeMethod: "/method/friends.get", params: params)

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            guard let data = data else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Response<User>.self, from: data).response.items
                completion(.success(result))
               
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

