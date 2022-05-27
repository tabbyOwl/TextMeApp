////
////  NewsData.swift
////  TextMeApp
////
////  Created by jane on 13.05.2022.
////
//
//import Foundation
//import UIKit
//
//
//
//class NewsData {
//
//    func loadData(completion: @escaping ([RealmNews]) -> Void) {
//
//        var urlConstructor = URLComponents()
//        urlConstructor.scheme = "https"
//        urlConstructor.host = "api.vk.com"
//        urlConstructor.path = "/method/newsfeed.get"
//        urlConstructor.queryItems = [
//            URLQueryItem(name: "access_token", value: String(Session.instance.token)),
//            URLQueryItem(name: "v", value: "5.131"),
//            URLQueryItem(name: "user_id", value: String(Session.instance.userID)),
//            URLQueryItem(name: "filters", value: "photo, post"),
//            URLQueryItem(name: "return_banned", value: "0"),
//            URLQueryItem(name: "start_time", value: "1651363200")
//            //URLQueryItem(name: "count", value: "13"),
//        ]
//
//        guard let url = urlConstructor.url else {return}
//
//        URLSession.shared.dataTask(with: url) { (data, _, _) in
//            guard let data = data else {return}
//
//            do {
//                let model = try JSONDecoder().decode(NewsResponse.self, from: data)
//                var news: [News] = []
//
//                let photos: [Photo] = items.map { item in
//
//                    let photo = Photo(id: item.id,
//                                      sizes: [PhotoUrl(url: item.sizes.last?.url ?? "")],
//                                      likes: Likes(user_likes: item.likes.user_likes,count: item.likes.count),
//                                      ownerId: item.ownerId)
//    //                photo.id = item.id
//    //                photo.url = item.sizes.last?.url ?? ""
//    //                photo.likes = item.likes.count
//    //                photo.isLiked = item.likes.user_likes
//    //                photo.ownerId = item.ownerId
//
//                    return photo
//                    }
//                    completion(photos)
//
//            }.resume()
//        }
//    }
////                for i in 0...model.response.items.count-1 {
////                    let text = model.response.items[i].text
////
////                    var urls: [URL] = []
////                    if model.response.items[i].type == "photo" {
////                        for j in 0...(model.response.items[i].photos?.items?.count ?? 0) {
////                            if let url = URL(string: model.response.items[i].photos?.items?[j].sizes?[0].url ?? "") {
////                            urls.append(url)
////                            }
////                    }
////                    } else {
////                        if let url = URL(string: model.response.items[i].attachments?[0].photo?.sizes?[0].url ?? "") {
////                        urls.append(url)
////                        }
////                    }
////                    news.append(News(text: text, imageUrls: urls))
////                }
////
////                    completion(news)
////            } catch let error {
////                print("🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️🅰️(\(error)")
////            }
////        }.resume()
////    }
////}
