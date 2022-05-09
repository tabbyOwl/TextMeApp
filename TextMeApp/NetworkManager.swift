//
//  NetworkManager.swift
//  TextMeApp
//
//  Created by jane on 08.05.2022.
//

import Foundation

class NetworkManager {
    
    func request(with url: URL) {
        URLSession.shared.dataTask(with: url){data, _, _ in
            guard let data = data else {return}
            let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            print(json)
        }
        .resume()
    }
    
    func loadData(methodParameters: String, queryItems: [URLQueryItem] = []) {
        
        var urlConstructor = URLComponents()
                urlConstructor.scheme = "https"
                urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/"+methodParameters
                urlConstructor.queryItems = [
                    URLQueryItem(name: "access_token", value: String(Session.instance.token)),
                    URLQueryItem(name: "v", value: "5.131")
                ]
        queryItems.forEach { queryItem in
            urlConstructor.queryItems?.append(queryItem)
            }
        guard let url = urlConstructor.url else {return}
        request(with: url)
    }
    
}
