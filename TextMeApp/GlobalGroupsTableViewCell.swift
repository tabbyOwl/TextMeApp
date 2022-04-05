//
//  GlobalGroupsTableViewCell.swift
//  TextMeApp
//
//  Created by jane on 30.03.2022.
//

import UIKit

class GlobalGroupsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
   
    @IBOutlet weak var button: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
