//
//  Likes.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 12.06.2022.
//

import RealmSwift


struct Likes: Decodable {
    
    var userLikes: Int
    
    var likesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case likesCount = "count"
    }
    
    var isLiked: Bool {
        
          return userLikes == 0 ? false : true
    }

}
