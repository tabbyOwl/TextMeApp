//
//  NewsResponse.swift
//  TextMeApp
//
//  Created by Svetlana Oleinikova on 27.05.2022.
//

import Foundation

 struct News: Decodable {
    let type: String
    let userPhoto: UserPhoto?
    let text: String?
    let attachments: [Attachments]?
     
     enum NewsType: String {
         case imageOnly = "ImageNewsCell"
         case textOnly = "TextNewsCell"
         case imageAndText = "ImageAndTextCell"
     }
 
     var newsType: NewsType? {
         let hasImage = attachments != nil
         let hasText = text != nil
         
         switch (hasImage, hasText) {
         case (true, true): return .imageAndText
         case (true, false): return .imageOnly
         case (false, true): return .textOnly
         case (false, false): return nil
         }
     }
}

 struct Attachments: Decodable {
    let photo: Photos?
}

 struct Photos: Decodable {
    let urls: [PhotoUrl]?
     
     enum CodingKeys: String, CodingKey {
         case urls = "sizes"
     }
   
}

 struct UserPhoto: Decodable {
    let photos: [UserPhotos]?
   
}
 struct UserPhotos: Decodable {
    let urls: [PhotoUrl]?
     
     enum CodingKeys: String, CodingKey {
         case urls = "sizes"
     }
}

