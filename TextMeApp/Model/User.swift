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
    var avatar = UIImage(named: "defaultAvatar")
    var isSuscribe = false
    
    var photos: [UIImage?] = []
    
  
}
