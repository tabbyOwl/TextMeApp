//
//  UserRealm.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 12.06.2022.
//

import RealmSwift

class RealmUser: Object {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var firstName: String
    
    @Persisted
    var lastName: String
    
    @Persisted
    var avatar: String
    
 
    
    @Persisted
    var photos = List<RealmPhoto>()
}

