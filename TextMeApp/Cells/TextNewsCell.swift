//
//  TextNewsCell.swift
//  TextMeApp
//
//  Created by jane on 13.05.2022.
//

import Foundation
import UIKit

class TextNewsCell: UITableViewCell {
    
    static let identifier = String(describing: "TextNewsCell")
    
    @IBOutlet weak var newsLabel: UILabel?
}

extension TextNewsCell: NewsCellProtocol {
    func set<T: NewsCellDataProtocol>(value: T) {
        newsLabel?.text = value.text
    }
}
