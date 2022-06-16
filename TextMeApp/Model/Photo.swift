//
//  Photo.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 16.06.2022.
//

import Foundation

struct Photo: Decodable {
    
    let id: Int
    let sizes: [Sizes]
    let likes: Likes?
    let ownerId: Int
    
    var url: String {
        sizes.last?.url ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case sizes
        case likes
        case ownerId = "owner_id"
       
    }
}
