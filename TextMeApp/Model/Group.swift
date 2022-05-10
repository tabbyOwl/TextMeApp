//
//  Group.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//

import Foundation
import UIKit

struct Group {

    let name: String
    var avatar: Photo = Photo(url: "groupDefaultAvatar")
    var isSuscribe = false
}

var globalGroups: [Group] = []
//    Group(name: "Котики", avatar: Photo(name: "cats"), isSuscribe: true), Group(name: "Сарказм", isSuscribe: true), Group(name: "Изучаем китайский", avatar: Photo(name: "chinese"),isSuscribe: true), Group(name: "Сказочные места", avatar: Photo(name: "places"), isSuscribe: true), Group(name: "Рецепты", avatar: Photo(name: "recipes")), Group(name: "Йога"), Group(name: "Английский по фильмам", avatar: Photo(name: "english")), Group(name: "Ешкин кот", avatar: Photo(name: "eshkinCat"))
//        ]
