//
//  RealmUser.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 22.05.2022.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    
    @Persisted
    var id: Int
    
    @Persisted
    var firstName: String
    
    @Persisted
    var lastName: String
    
    @Persisted
    var avatar: String
}
