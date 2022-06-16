//
//  PhotoRealm.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 12.06.2022.
//

import RealmSwift

final class RealmPhoto: Object {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var url: String
    
    @Persisted
    var likesCount: Int
    
    @Persisted
    var isLiked: Bool
    
    @Persisted
    var ownerId: Int
    
//    @Persisted
//    var user: RealmUser?
//    
}
 

