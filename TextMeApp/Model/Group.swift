//
//  Group.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 16.06.2022.
//

import RealmSwift

class Group: Object, Decodable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var name: String
    
    @Persisted
    var avatar: String
    
    @Persisted
    var isMember: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_50"
        case isMember = "is_member"
    }
    
    var isSuscribe: Bool {
        get {
            isMember == 1 ? true: false
        }
        set {
            if newValue {
                isMember = 1
            } else {
                isMember = 0
            }
        }
    }
}
