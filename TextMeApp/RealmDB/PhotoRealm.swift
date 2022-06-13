//
//  PhotoRealm.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 12.06.2022.
//

import RealmSwift

class PhotoRealm: Object, Decodable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var urls: List<PhotoUrl>
    
    var likes: Likes
    
    @Persisted
    var likesCounter: Int
    
    @Persisted
    var isLiked: Bool
    
    @Persisted
    var ownerId: Int
    
    @Persisted
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case urls = "sizes"
        case likes
        case ownerId = "owner_id"
    }
    
}
 

