//
//  Session.swift
//  TextMeApp
//
//  Created by jane on 08.05.2022.
//

import Foundation

struct Session {
    
    private init() {}
    
    static var instance = Session()
    
    var token: String = ""
    var userID: Int = 0
}



