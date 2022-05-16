//
//  NewsData.swift
//  TextMeApp
//
//  Created by jane on 13.05.2022.
//

import Foundation
import UIKit

private struct NewsResponse: Decodable {
   let response: Response
}

private struct Response : Decodable {
    let items: [Items]
}

private struct Items: Decodable {
    let type: String
    let photos: UserPhotos?
    let text: String?
    let attachments: [Attachments]?
}

private struct Attachments: Decodable {
    let photo: Photos?
}

private struct Photos: Decodable {
    let sizes: [Sizes]?
   
}
private struct Sizes: Decodable {
    let url: String?
}

private struct UserPhotos: Decodable {
    let items: [Items2]?
   
}
private struct Items2: Decodable {
    let sizes: [Sizes]?
}

class NewsData {
    
    func loadData(completion: @escaping ([News]) -> Void) {
        
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/newsfeed.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: String(Session.instance.token)),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "user_id", value: String(Session.instance.userID)),
            URLQueryItem(name: "filters", value: "photo, post"),
            URLQueryItem(name: "return_banned", value: "0"),
            URLQueryItem(name: "start_time", value: "1651363200")
            //URLQueryItem(name: "count", value: "13"),
        ]
        
        guard let url = urlConstructor.url else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
           
            let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            print(json)
            
            do {
                let model = try JSONDecoder().decode(NewsResponse.self, from: data)
                var news: [News] = []
                
                for i in 0...model.response.items.count-1 {
                    let text = model.response.items[i].text
                    var url = URL(string: "")
                    if model.response.items[i].type == "photo" {
                        url = URL(string: model.response.items[i].photos?.items?[0].sizes?[0].url ?? "")
                    } else {
                       url = URL(string: model.response.items[i].attachments?[0].photo?.sizes?[0].url ?? "")
                    }
                    news.append(News(text: text, imageUrl: url))
                }
                    completion(news)
            } catch let error {
                print("🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️(\(error)")
            }
        }.resume()
    }
}
