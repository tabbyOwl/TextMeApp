//
//  Photo.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 12.06.2022.
//

import Foundation

struct Photo : Decodable {
    
    let id: Int
    let urls: [PhotoUrl]
    var likes: Likes
    let ownerId: Int
    
    var isLiked {
        
    }
  
    
}
