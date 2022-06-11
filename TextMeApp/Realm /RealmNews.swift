////
////  News.swift
////  TextMeApp
////
////  Created by jane on 12.04.2022.
////
//
//import Foundation
//import UIKit
//
//struct RealmNews {
//    
//    
//    
//    enum NewsType: String {
//        case imageOnly = "ImageNewsCell"
//        case textOnly = "TextNewsCell"
//        case imageAndText = "ImageAndTextCell"
//    }
//    
//    let text: String?
//    let imageUrls: [URL]?
//    //let autor: Any
//    //let date: String
//    
//    var newsType: NewsType? {
//        let hasImage = imageUrls != nil
//        let hasText = text != nil
//        
//        switch (hasImage, hasText) {
//        case (true, true): return .imageAndText
//        case (true, false): return .imageOnly
//        case (false, true): return .textOnly
//        case (false, false): return nil
//        }
//    }
//}
//
//
