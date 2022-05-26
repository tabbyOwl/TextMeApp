//
//  UIImage+URL.swift
//  TextMeApp
//
//  Created by jane on 10.05.2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func load(url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {return}
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
                print("LOAD PHOTO 🎨🎨🎨🎨🎨🎨🎨🎨🎨🎨🎨🎨🎨🎨🎨🎨🎨🎨🎨🎨🎨🎨")
            }
        }.resume()
    }
    
}


