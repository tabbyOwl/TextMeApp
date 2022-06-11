//
//  NewsService.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 03.06.2022.
//

import Foundation

final class NewsService {

    typealias NewsResult = Result<[News], Error>

    func loadNews(completion: @escaping(NewsResult) -> ()) {
  
        let params = [
            "v": "5.131",
            "user_id": String(Session.instance.userID),
            "filters": "post",
            "count": "200",
            "start_time": "1651363200"
        ]

        let url: URL = .configureURL(token: Session.instance.token, typeMethod: "/method/newsfeed.get", params: params)

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            guard let data = data else {
                return
            }
            let decoder = JSONDecoder()

            do {
                let result = try decoder.decode(Response<News>.self, from: data).response.items
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()

    }
}
