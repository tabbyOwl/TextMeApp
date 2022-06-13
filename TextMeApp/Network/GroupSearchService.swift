//
//  GroupSearchService.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 03.06.2022.
//

import Foundation

final class GroupSearchService {

    typealias GroupResult = Result<[GroupRealm], Error>

    func loadGroups(searchText: String, completion: @escaping(GroupResult) -> ()) {
    
        let params = [
            "extended": "1",
            "user_id": String(Session.instance.userID),
            "v": "5.131",
            "q": searchText
        ]

        let url: URL = .configureURL(token: Session.instance.token, typeMethod: "/method/groups.search", params: params)

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            guard let data = data else {
                return
            }
            let decoder = JSONDecoder()

            do {
                let result = try decoder.decode(Response<GroupRealm>.self, from: data).response.items
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()

    }
}


