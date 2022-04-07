//
//  MyFriendsCell.swift
//  TextMeApp
//
//  Created by jane on 28.03.2022.
//

import UIKit

class MyFriendsTableCell: UITableViewCell {

    
    @IBOutlet weak var friendName: UILabel!
   
  
    @IBOutlet weak var friendImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
