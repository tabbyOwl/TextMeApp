//
//  RealmPhoto.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 23.05.2022.
//

import Foundation
import RealmSwift

class RealmPhoto: Object {
    
    @Persisted
    var url: String
    
}

