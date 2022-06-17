//
//  Photo.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 16.06.2022.
//

import RealmSwift

class Photo: Object, Decodable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var sizes = List<Sizes>()
    
    @Persisted
    var likes: Likes?
    
    @Persisted
    var ownerId: Int
    
   
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
