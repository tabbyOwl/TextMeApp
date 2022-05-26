//
//  UserResponse.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 24.05.2022.
//

import Foundation

struct UserResponse: Decodable {
  let response: UsersResponse
}

struct UsersResponse : Decodable {
  let items: [User]
}

struct User: Decodable {
  let id: Int
  let firstName: String
  let lastName: String
  let avatar: String
  
  enum CodingKeys: String, CodingKey {
      case id
      case firstName = "first_name"
      case lastName = "last_name"
      case avatar = "photo_100"
      }
  }
