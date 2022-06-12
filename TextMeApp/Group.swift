//
//  GroupApi.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 24.05.2022.
//

import Foundation

// struct GroupResponse: Decodable {
//    let response: GroupsResponse
//}
 
//struct GroupsResponse: Decodable {
//    let count: Int
//    let groups: [Group]
//    
//    enum CodingKeys: String, CodingKey {
//        case count
//        case groups = "items"
//    }
//}

 struct Group: Decodable {
    let id: Int
    let name: String
    let avatar: String
    var is_member: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_50"
        case is_member
        
    }
     
     var isSuscribe: Bool {
         get {
             is_member == 1 ? true: false
         }
         set {
             if newValue {
                 is_member = 1
             } else {
                 is_member = 0
             }
         }
     }
 }
