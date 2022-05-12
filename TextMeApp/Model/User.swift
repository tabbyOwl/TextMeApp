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
//    User(name: "Ирина Каткова", avatar: Photo(image: "user5"), photos: [Photo(image: "photo1"), Photo(image: "photo2"), Photo(image: "photo3"),Photo(image: "i"),Photo(image: "i-1"),Photo(image: "i-2"),Photo(image: "i-3"),Photo(image: "i-4"),Photo(image: "i-5"),Photo(image: "i-6")]),
//        User(name: "Денис Скороходов", avatar: Photo(image: "user1"), photos: [ Photo(image: "i-7"), Photo(image: "i-8"), Photo(image: "i-9"),Photo(image: "i-10"),Photo(image: "i-11"),Photo(image: "i-12"),Photo(image: "i-13"),Photo(image: "i-14"),Photo(image: "i-15"),Photo(image: "i-16"),Photo(image: "i-17"),Photo(image: "i-18"),Photo(image: "i-19")]),
//        User(name: "Лиза Артемьева", avatar: Photo(image: "user2"), photos: [Photo(image: "i-25"),Photo(image: "i-26"),Photo(image: "i"),Photo(image: "i-27")]),
//        User(name: "Тимофей Иванов",avatar: Photo(image: "user5"), photos: [Photo(image: "i-20"),Photo(image: "i-21"),Photo(image: "i-22"), Photo(image: "i-23"),Photo(image: "i-24")]),
//        User(name: "Данил Дубровский"),
//        User(name: "Иван Петров"),
//        User(name: "Арина Тинькова"),
//        User(name: "Анастасия Гордон", photos: [Photo(image: "i-27")]),
//        User(name: "Павел Яковлев", photos: [Photo(image: "i-25"), Photo(image: "i-25")])
//]
//
//
