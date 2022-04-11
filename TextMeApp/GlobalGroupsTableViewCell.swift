//
//  GlobalGroupsTableViewCell.swift
//  TextMeApp
//
//  Created by jane on 30.03.2022.
//

import UIKit

class GlobalGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize(width: 10, height: 10)
        shadowView.layer.backgroundColor = UIColor.clear.cgColor
        avatarImageView.layer.cornerRadius = 25
        avatarImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
