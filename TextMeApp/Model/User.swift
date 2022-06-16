//
//  UserSwift.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 16.06.2022.
//

import Foundation

struct User: Decodable {
    
    let id: Int
    let firstName: String
    let lastName: String
    let avatar: String
    
    var photos: [Photo] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_100"
    }
}
