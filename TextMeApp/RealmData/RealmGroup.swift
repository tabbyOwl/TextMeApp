//
//  RealmGroup.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 23.05.2022.
//

import Foundation
import RealmSwift

class RealmGroup: Object {
    
    @Persisted
    var id: Int
    
    @Persisted
    var name: String
    
    @Persisted
    var avatar: String
}
