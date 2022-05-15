//
//  UIImage+URL.swift
//  TextMeApp
//
//  Created by jane on 10.05.2022.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL, imageView: UIImageView) {
         DispatchQueue.global().async { [weak self] in
             if let data = try? Data(contentsOf: url) {
                 if let image = UIImage(data: data) {
                     DispatchQueue.main.async {
                         imageView.image = image
                         //self?.image = image
                     }
                 }
             }
         }
     }
 }
