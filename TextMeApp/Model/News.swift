//
//  News.swift
//  TextMeApp
//
//  Created by jane on 12.04.2022.
//

import Foundation
import UIKit

struct News {
    
    let autor: Any
    let date: String
    let text: String
    var image = Photo(name: "")
    var likesCounter = 0
}

var allNews = [
    News(autor: globalGroups[3] , date: "12.04.2022", text: "Сегодня чудесная погода!", image: Photo(name: "photo3")),
News(autor: allUsers[3] , date: "12.04.2022", text: "Мой пушок ♥️", image: Photo(name: "i-10")),
News(autor: globalGroups[0] , date: "12.04.2022", text: "Выставка бездомных животных пройдет в эти выходные по адресу Красноармейская 89б ТЦ ЛИГА. Питомцы доброжелательно настроены по отношению к людям, здоровы, привиты и готовы стать домашними.", image: Photo(name: "i-2")),
News(autor: allUsers[2], date: "12.04.2022", text: "Сегодня побывали в замечатльном месте", image: Photo(name: "i-4"))
]
