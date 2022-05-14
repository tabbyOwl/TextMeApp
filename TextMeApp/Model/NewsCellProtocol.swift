//
//  NewsCellProtocol.swift
//  TextMeApp
//
//  Created by jane on 13.05.2022.
//

import Foundation

protocol NewsCellProtocol {
    func set<T:NewsCellDataProtocol>(value: T)
}

protocol NewsCellDataProtocol {
    var text: String? { get }
    var imageUrl: URL? { get }
}

extension News: NewsCellDataProtocol {}
