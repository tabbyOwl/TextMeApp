//
//  PhotoUrl.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 03.06.2022.
//

import RealmSwift


class Sizes: Object, Decodable {

    @Persisted
    var url: String
    
}
