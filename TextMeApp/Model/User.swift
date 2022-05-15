//
//  File.swift
//  TextMeApp
//
//  Created by jane on 28.03.2022.
//

import Foundation
import UIKit

struct User {

    let id: Int
    let name: String
    var avatar: Photo = Photo(id: 0, url: "userDefaultAvatar")
    var isSuscribe = false

    var photos: [Photo] = []
}

var allUsers: [User] = []

