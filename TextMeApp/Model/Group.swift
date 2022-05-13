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
    var avatar: Photo = Photo(id: 0, url: "groupDefaultAvatar")
    var isSuscribe = false
}

var globalGroups: [Group] = []

