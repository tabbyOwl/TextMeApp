//
//  PhotoService.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 03.06.2022.
//

import Foundation

final class PhotoService {

    typealias PhotoResult = Result<[PhotoRealm], Error>

    //MARK: public methods
    
    func loadPhotos(userId: Int, completion: @escaping(PhotoResult) -> ()) {
    
        let params = [
            "extended": "1",
            "v": "5.131",
            "user_id": String(Session.instance.userID),
            "fields": "photo_100",
            "count": "200",
            "owner_id": String(userId)
        ]

        let url: URL = .configureURL(token: Session.instance.token, typeMethod: "/method/photos.getAll", params: params)

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            guard let data = data else {
                return
            }
            let decoder = JSONDecoder()

            do {
                let result = try decoder.decode(Response<PhotoRealm>.self, from: data).response.items
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()

    }
}
