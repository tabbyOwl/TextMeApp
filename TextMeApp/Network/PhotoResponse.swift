//
//  PhotoResponse.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 24.05.2022.
//

import Foundation

 struct PhotoResponse: Decodable {
    let response: PhotosResponse
}

 struct PhotosResponse : Decodable {
    let count: Int
    let items: [Photo]
}

 struct Photo: Decodable {
    let id: Int
    let sizes: [PhotoUrl]
    let likes: Likes
    let ownerId: Int
     
     enum CodingKeys: String, CodingKey {
         case id
         case sizes
         case likes
         case ownerId = "owner_id"
     }
 }

 struct PhotoUrl: Decodable {
    let url: String
   
}

 struct Likes: Decodable {
    let user_likes: Int
    let count: Int
}
