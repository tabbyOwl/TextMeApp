//
//  PhotoResponse.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 24.05.2022.
//

import Foundation

// struct PhotoResponse: Decodable {
//    let response: PhotosResponse
//}

struct PhotosResponse : Decodable {
    let count: Int
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case count
        case photos = "items"
    }
}

 struct Photo: Decodable {
    let id: Int
    let urls: [PhotoUrl]
    let likes: Likes
    let ownerId: Int
     
     enum CodingKeys: String, CodingKey {
         case id
         case urls = "sizes"
         case likes
         case ownerId = "owner_id"
     }
 }

 struct Likes: Decodable {
    let user_likes: Int
    let count: Int
}
