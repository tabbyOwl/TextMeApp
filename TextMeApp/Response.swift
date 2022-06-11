//
//  Response.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 03.06.2022.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let response: Items<T>
}

struct Items<T: Decodable>: Decodable {
    let items: [T]

    enum CodingKeys: String, CodingKey {
        case items
    }
}
