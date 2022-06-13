//
//  UserRealm.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 12.06.2022.
//

import RealmSwift

class UserRealm: Object, Decodable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var firstName: String
    
    @Persisted
    var lastName: String
    
    @Persisted
    var avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_100"
    }
    
    @Persisted
    var photos: List<PhotoRealm>
}

