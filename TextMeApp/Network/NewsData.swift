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
    let text: String
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
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "return_banned", value: "0"),
            URLQueryItem(name: "start_time", value: "1651363200")
        ]
        
        guard let url = urlConstructor.url else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
                
            do {
                let model = try JSONDecoder().decode(NewsResponse.self, from: data)
                
                var news: [News] = []
                
                for i in 0...model.response.items.count-1 {
                    let text = model.response.items[i].text
                
                    news.append(News(text: text, imageUrl: nil))
                }
                    completion(news)
            } catch let error {
                print("🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️(\(error)")
            }
        }.resume()
    }
}

//class NewsData {
//
//    func loadData(completion: @escaping ([News]) -> Void) {
//
//    var urlConstructor = URLComponents()
//            urlConstructor.scheme = "https"
//            urlConstructor.host = "api.vk.com"
//    urlConstructor.path = "/method/newsfeed.get"
//            urlConstructor.queryItems = [
//                URLQueryItem(name: "access_token", value: String(Session.instance.token)),
//                URLQueryItem(name: "v", value: "5.131"),
//                URLQueryItem(name: "user_id", value: String(Session.instance.userID)),
//                URLQueryItem(name: "filters", value: "post"),
//                URLQueryItem(name: "return_banned", value: "0"),
//                URLQueryItem(name: "start_time", value: "1651363200")
//            ]
//
//        guard let url = urlConstructor.url else {return}
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else {return}
//               print("❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️\(response), \(error)")
//            do {
//                let model = try JSONDecoder().decode(NewsResponse.self, from: data)
//
//                var news: [News] = []
//
//                for i in 0...model.response.items.count-1 {
//                    let text = model.response.items[i].text
//                    //let imageUrl = URL(string: model.response.items[i].attachments.photo.sizes[i].url)
//                    news.append(News(text: text, imageUrl: nil))
//                }
//                print("❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️\(news)")
//                completion(news)
//            } catch {
//                print(error)
//            }
//        }.resume()
//    }
//}
//
//
