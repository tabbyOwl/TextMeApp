//
//  NewsResponse.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 27.05.2022.
//

import Foundation

struct NewsResponse: Decodable {
   let response: ResponseNews
}

struct ResponseNews : Decodable {
    let items: [News]
}

 struct News: Decodable {
    let type: String
    let photos: UserPhotos?
    let text: String?
    let attachments: [Attachments]?
}

 struct Attachments: Decodable {
    let photo: Photos?
}

 struct Photos: Decodable {
    let sizes: [PhotoUrls]?
   
}
 struct PhotoUrls: Decodable {
    let url: String?
}

 struct UserPhotos: Decodable {
    let items: [Items]?
   
}
 struct Items: Decodable {
    let sizes: [PhotoUrls]?
}
