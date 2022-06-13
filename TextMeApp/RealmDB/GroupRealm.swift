//
//  GroupRealm.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 12.06.2022.
//

import RealmSwift

class GroupRealm: Object, Decodable {
    
    @Persisted
    var id: Int
    
    @Persisted
    var name: String
    
    @Persisted
    var avatar: String
    
    @Persisted
    var is_member: Int
    
   enum CodingKeys: String, CodingKey {
       case id
       case name
       case avatar = "photo_50"
       case is_member
       
   }
    
    var isSuscribe: Bool {
        get {
            is_member == 1 ? true: false
        }
        set {
            if newValue {
                is_member = 1
            } else {
                is_member = 0
            }
        }
    }
}
