//
//  GroupService.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 03.06.2022.
//

import Foundation

final class GroupService {

    typealias GroupResult = Result<[Group], Error>

    func loadGroups(completion: @escaping(GroupResult) -> ()) {
    
        let params = [
            "extended": "1",
            "user_id": String(Session.instance.userID),
            "v": "5.131"
        ]

        let url: URL = .configureURL(token: Session.instance.token, typeMethod: "/method/groups.get", params: params)

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            guard let data = data else {
                return
            }
         
            do {
                let result = try JSONDecoder().decode(Response<Group>.self, from: data).response.items
                completion(.success(result))
             
            } catch {
                completion(.failure(error))
              
            }
        }.resume()

    }
}


