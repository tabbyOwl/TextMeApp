//
//  Likes.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 12.06.2022.
//


struct Likes: Decodable {
    
    var user_likes: Int
    
    var count: Int
    
    var isLiked: Bool {
        get {
            user_likes == 0 ? false : true
        }
        set {
            if newValue {
                user_likes = 1
            } else {
                user_likes = 0
            }
        }
    }

}
