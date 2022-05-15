//
//  ImageAndTextCell.swift
//  TextMeApp
//
//  Created by jane on 13.05.2022.
//

import Foundation
import UIKit
class ImageAndTextCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView?
    @IBOutlet weak var newsLabel: UILabel?
    
    private lazy var newNewsImageView: UIImageView = {
        let height = bounds.height * 0.95
        let width = bounds.width * 0.95
        
        let topDiff = (bounds.height - height) / 2
        let leftDiff = (bounds.width - width) / 2
        
        let frame = CGRect(x: leftDiff, y: topDiff, width: width, height: height)
        let nImageView = UIImageView(frame: frame)
        
        addSubview(nImageView)
        
        return nImageView
    } ()
}

extension ImageAndTextCell: NewsCellProtocol {
    func set<T: NewsCellDataProtocol>(value: T) {
        UIImageView().load(url: value.imageUrl!, imageView: newNewsImageView)
        newsLabel?.text = value.text
    }
}
