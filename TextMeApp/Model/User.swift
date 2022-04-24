//
//  File.swift
//  TextMeApp
//
//  Created by jane on 28.03.2022.
//

import Foundation
import UIKit

struct User {
    
    let id: UUID = .init()
    let name: String
    var avatar: Photo = Photo(name: "userDefaultAvatar")
    var isSuscribe = false
    
    var photos: [Photo] = []
    
  
}

var allUsers = [
    User(name: "Ирина Каткова", avatar: Photo(name: "user5"), photos: [Photo(name: "photo1"), Photo(name: "photo2"), Photo(name: "photo3"),Photo(name: "i"),Photo(name: "i-1"),Photo(name: "i-2"),Photo(name: "i-3"),Photo(name: "i-4"),Photo(name: "i-5"),Photo(name: "i-6")]),
        User(name: "Денис Скороходов", avatar: Photo(name: "user1"), photos: [ Photo(name: "i-7"), Photo(name: "i-8"), Photo(name: "i-9"),Photo(name: "i-10"),Photo(name: "i-11"),Photo(name: "i-12"),Photo(name: "i-13"),Photo(name: "i-14"),Photo(name: "i-15"),Photo(name: "i-16"),Photo(name: "i-17"),Photo(name: "i-18"),Photo(name: "i-19")]),
        User(name: "Лиза Артемьева", avatar: Photo(name: "user2"), photos: [Photo(name: "i-25"),Photo(name: "i-26"),Photo(name: "i"),Photo(name: "i-27")]),
        User(name: "Тимофей Иванов",avatar: Photo(name: "user5"), photos: [Photo(name: "i-20"),Photo(name: "i-21"),Photo(name: "i-22"), Photo(name: "i-23"),Photo(name: "i-24")]),
        User(name: "Данил Дубровский"),
        User(name: "Иван Петров"),
        User(name: "Арина Тинькова"),
        User(name: "Анастасия Гордон", photos: [Photo(name: "i-27")]),
        User(name: "Павел Яковлев", photos: [Photo(name: "i-25"), Photo(name: "i-25")])
]


