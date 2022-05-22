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
    let access_key: String
    let sizes: [Sizes]?
   
}
private struct Sizes: Decodable {
    let url: String?
}

private struct UserPhotos: Decodable {
    let items: [PhotoItems]?

   
}
private struct PhotoItems: Decodable {
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
                let items = model.response.items
                
                for item in items {
                    var urls: [URL] = []
                    let text = item.text
                    print (item.type)
                    if item.type == "photo" {
                        if let url = URL (string: item.photos?.items?[0].sizes?[0].url ?? "") {
                        urls.append(url)
                        }
                    } else if item.type == "post" {
                        if let url = URL(string: item.attachments?[0].photo?.sizes?[0].url ?? "") {
                        urls.append(url)
                    }
                    }
                    
                    news.append(News(text: text, imageUrls: urls))
                 
                }
                    completion(news)
            } catch let error {
              print(error)
            }
        }.resume()
    }
}


//                    if item.type == "photo" {
//
//                        guard let photoItems = item.photos?.items else {return}
//
//                        for photoItem in photoItems {
//                            guard let sizes = photoItem.sizes else {return}
//
//                            for siz in sizes {
//                                guard let urlString = siz.url else {return}
//                                if let url = URL(string: urlString) {
//                                urls.append(url)
//                                }
//                            }
//                        }
//                    } else
//                    if item.type == "post" {

//                    if item.type == "photo" {
//                        guard let photoItems = item.photos?.items else {return}
//                        print("🍋🍋🍋🍋🍋🍋🍋🍋🍋🍋🍋🍋🍋\(photoItems.count)")
//                                            for photoItem in photoItems {
//
//                                                guard let sizes = photoItem.sizes else {return}
//                                                for s in sizes {
//                                                    guard let urlString = s.url else {return}
//                                                    if let url = URL(string: urlString) {
//                                                    urls.append(url)
//                                                    }
//                                                }
//                                            }
    
    //guard let attachments = item.attachments else {return}
