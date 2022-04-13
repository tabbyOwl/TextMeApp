//
//  News.swift
//  TextMeApp
//
//  Created by jane on 12.04.2022.
//

import Foundation
import UIKit

struct News {
    
    let user: User
    let date: String
    let text: String
    var image = UIImage(named: "noPhoto")
    var likesCounter = 0
}
