//
//  Likes.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 12.06.2022.
//

import RealmSwift


class Likes: Object, Decodable {
    
    @Persisted
    var userLikes: Int
    
    @Persisted
    var likesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case likesCount = "count"
        
    }
    
    var isLiked: Bool {
        get {
            userLikes == 0 ? false : true
        }
        set {
            if newValue {
                userLikes = 1
            } else {
                userLikes = 0
            }
        }
    }

}
