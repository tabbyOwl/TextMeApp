//
//  URL+Config.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 03.06.2022.
//

import Foundation

extension URL {
    static func configureURL(token: String,
                             typeMethod: String,
                             params: [String: String]) -> URL {

        var queryItems: [URLQueryItem] = []
        params.forEach { name, value in
            queryItems.append(URLQueryItem(name: name, value: value))
        }

        queryItems.append(.init(name: "access_token", value: token))

        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = typeMethod
        components.queryItems = queryItems

        guard let url = components.url else { fatalError("") }

        return url
    }
}
