//
//  MyGroupsTableCell.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//

import UIKit



class MyGroupsTableCell: UITableViewCell {

   
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
