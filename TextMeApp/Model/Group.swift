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
    var avatar = UIImage(named: "groupDefaultAvatar")
    var isSuscribe = false
}

var globalGroups = [
    Group(name: "Котики", avatar: UIImage(named: "cats"), isSuscribe: true), Group(name: "Сарказм", isSuscribe: true), Group(name: "Изучаем китайскийИзучаем китайскийИзучаем китайскийИзучаем китайскийИзучаем китайский", avatar: UIImage(named: "chinese"),isSuscribe: true), Group(name: "Сказочные места", avatar: UIImage(named: "places"), isSuscribe: true), Group(name: "Рецепты", avatar: UIImage(named: "recipes")), Group(name: "Йога"), Group(name: "Английский по фильмам", avatar: UIImage(named: "english")), Group(name: "Ешкин кот", avatar: UIImage(named: "eshkinCat"))
        ]
