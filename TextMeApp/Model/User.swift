//
//  File.swift
//  TextMeApp
//
//  Created by jane on 28.03.2022.
//

import Foundation
import UIKit

//final class User : Decodable {
//
//    init(from decoder: Decoder) throws {
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        id = try container.decode(Int.self, forKey: .id)
//        name = try container.decode(String.self, forKey: .name)
//        lastName = try container.decode(String.self, forKey: .lastName)
//    }
//
//    let id: Int
//    let name: String
//    let lastName: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name = "first_name"
//        case lastName = "last_name"
//    }
//}


struct User {

    let id: Int
    let name: String
    var avatar: Photo = Photo(id: 0, url: "userDefaultAvatar")
    var isSuscribe = false

    var photos: [Photo] = []


}

var allUsers: [User] = []

