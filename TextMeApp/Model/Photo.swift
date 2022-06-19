//
//  Photo.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 16.06.2022.
//

import RealmSwift

class Photo: Object, Decodable {
    
    @Persisted
    var id: Int
    
    var sizes: [Sizes]
    
    var likes: Likes?
    
    @Persisted
    var ownerId: Int
    
   @Persisted
    var likesCount: Int
    
    @Persisted
    var isLiked: Bool
    
    @Persisted
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case sizes
        case likes
        case ownerId = "owner_id"
       
    }
}
